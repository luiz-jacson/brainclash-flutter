// import 'dart:convert';
// import 'dart:math';
// import 'package:flutter_brainclash/config/api_config.dart';
// import 'package:flutter_brainclash/config/api_key.dart';
// import 'package:flutter_brainclash/models/categoria.dart';
// import 'package:flutter_brainclash/models/pergunta.dart';
// import 'package:http/http.dart';

// class PerguntaService {
//   final Map<String, String> _headers = {
//     "Authorization": "Bearer ${gitHubApiKey}",
//   };

//   int gerarNumeroAleatorio(int maximo) {
//     final random = Random();
//     return random.nextInt(maximo);
//   }

//   Future<Pergunta> getPerguntabyCategoria(Categoria categoria) async {
//     Response response = await get(
//       Uri.parse(ApiConfig.getUrlPerguntas()),
//       headers: _headers,
//     );
//     Map<String, dynamic> mapResponse = json.decode(response.body);
//     List<dynamic> listaPerguntas = json.decode(
//       mapResponse["files"]["perguntas.json"]["content"],
//     );
//     List<Pergunta> listRandom = [];
//     for (Map<String, dynamic> pergunta in listaPerguntas) {
//       if (pergunta["idCategoria"] == categoria.id) {
//         Pergunta perguntaObj = Pergunta(
//           pergunta["idPergunta"],
//           pergunta["questao"],
//           List<String>.from(pergunta["respostas"]),
//           pergunta["respostaCorreta"],
//           pergunta["idCategoria"],
//         );
//         listRandom.add(perguntaObj);
//       }
//     }
//     int num = gerarNumeroAleatorio(listRandom.length);
//     return (listRandom[num]);
//   }

//   Future<List<Pergunta>> getAll() async {
//     Response response = await get(
//       Uri.parse(ApiConfig.getUrlPerguntas()),
//       headers: _headers,
//     );
//     List<Pergunta> perguntas = [];
//     Map<String, dynamic> mapResponse = json.decode(response.body);
//     List<dynamic> listaPerguntas = json.decode(
//       mapResponse["files"]["perguntas.json"]["content"],
//     );
//     for (Map<String, dynamic> item
//         in listaPerguntas) {
//       Pergunta pergunta = Pergunta(
//         item["idPergunta"],
//         item["questao"],
//         List<String>.from(item["respostas"]),
//         item["respostaCorreta"],
//         item["idCategoria"],
//       );
//       perguntas.add(pergunta);
//     }

//     return perguntas;
//   }

//   Future<List<Pergunta>> getAllByCategoria(Categoria categoria) async {
//     int idCategoria = categoria.getIdCategoria();
//     Response response = await get(
//       Uri.parse(ApiConfig.getUrlPerguntas()),
//       headers: _headers,
//     );
//     List<Pergunta> perguntas = [];
//     Map<String, dynamic> mapResponse = json.decode(response.body);
//     List<dynamic> listaResponse = json.decode(mapResponse["files"]["perguntas.json"]["content"]);
//     for (Map<String, dynamic> item in listaResponse) {
//       if (item["idCategoria"] == idCategoria) {
//         Pergunta pergunta = Pergunta(
//           item["idPergunta"],
//           item["questao"],
//           List<String>.from(item["respostas"]),
//           item["respostaCorreta"],
//           item["idCategoria"],
//         );
//         perguntas.add(pergunta);
//       }
//     }

//     return perguntas;
//   }

//   Future<int> calculaProximoId() async {
//     Response response = await get(
//       Uri.parse(ApiConfig.getUrlPerguntas()),
//       headers: _headers,
//     );
//     Map<String, dynamic> mapResponse = json.decode(response.body);
//     List<dynamic> listaResponse = json.decode(mapResponse["files"]["perguntas.json"]["content"]);
//     return listaResponse.length + 1;
//   }

//   ///Gerar pergunta com gemini
//   Future<void> gerarPerguntaGemini(Categoria categoria) async {
//     const int maxRetries = 3;

//     for (int attempt = 0; attempt < maxRetries; attempt++) {
//       List<Pergunta> existingPerguntas = await getAllByCategoria(categoria);

//       int nextId = 1;
//       if (existingPerguntas.isNotEmpty) {
//         nextId = await calculaProximoId();
//       }

//       List<String> existingPerguntasNames = existingPerguntas
//           .map((c) => c.getQuestao())
//           .toList();
//       String existingPerguntasString = existingPerguntasNames.join(', ');

//       final String prompt =
//           '''
// Gere APENAS o objeto JSON de UMA NOVA pergunta para um quiz na categoria "${categoria.getNome()}" (ID: ${categoria.getIdCategoria()}).
// A pergunta deve ter 4 opções de múltipla escolha e uma única resposta correta.
// A nova pergunta (o texto da questão) NÃO deve se repetir com as seguintes perguntas já existentes nesta categoria:
// $existingPerguntasString

// Defina o "idPergunta" para ${nextId.toString()}.
// O "idCategoria" deve ser ${categoria.getIdCategoria()}.
// A resposta deve ser APENAS o objeto JSON e nada mais, SEM TEXTO EXPLICATIVO, SEM MARKDOWN (como ```json).
// O formato JSON exato deve ser:
// {"idPergunta":NÚMERO,"questao":"TEXTO DA PERGUNTA","respostas":["OPCAO1","OPCAO2","OPCAO3","OPCAO4"],"respostaCorreta":"OPCAO CORRETA","idCategoria":NÚMERO}
// ''';

//       final Map<String, dynamic> requestBody = {
//         "contents": [
//           {
//             "parts": [
//               {"text": prompt},
//             ],
//           },
//         ],
//       };

//       print(
//         'Tentativa ${attempt + 1}: Solicitando nova categoria ao Gemini...',
//       );

//       try {
//         final response = await post(
//           Uri.parse(ApiConfig.apiGemini()),
//           headers: {'Content-Type': 'application/json'},
//           body: jsonEncode(requestBody),
//         );

//         if (response.statusCode == 200) {
//           final Map<String, dynamic> responseData = jsonDecode(response.body);

//           final String? generatedText =
//               responseData['candidates']?[0]?['content']?['parts']?[0]?['text']
//                   as String?;

//           print("Texto gerado (RAW): $generatedText");

//           if (generatedText != null && generatedText.isNotEmpty) {
//             String cleanJsonString = generatedText.trim();
//             cleanJsonString = cleanJsonString.replaceAll('\\"', '"');
//             print("Texto gerado (RAW): ${generatedText.trim()}");
//             try {
//               Map<String, dynamic> newPerguntaJson = json.decode(
//                 cleanJsonString,
//               );
//               Pergunta novaPerguntaGerada = Pergunta.fromMap(newPerguntaJson);
//               bool alreadyExists = existingPerguntas.any(
//                 (c) =>
//                     c.getQuestao().toLowerCase() ==
//                     novaPerguntaGerada.getQuestao().toLowerCase(),
//               );

//               if (alreadyExists) {
//                 print(
//                   'AVISO: Gemini gerou uma pergunta duplicada: "${novaPerguntaGerada.getQuestao()}". Tentando novamente...',
//                 );
//                 continue;
//               }
//               print(
//                 'Sucesso! Nova pergunta gerada pelo Gemini: ${novaPerguntaGerada.getQuestao()} (ID: ${novaPerguntaGerada.getIdPergunta()})',
//               );

//               postPerguntaNova(novaPerguntaGerada);
//               return;
//             } on FormatException catch (e) {
//               print(
//                 'ERRO DE DECODIFICAÇÃO JSON: $e. String recebida: $cleanJsonString. Tentando novamente...',
//               );
//             }
//           } else {
//             print(
//               'Gemini não gerou nenhum texto de pergunta. Tentando novamente...',
//             );
//           }
//         } else {
//           print('ERRO DA API Gemini (Status: ${response.statusCode}):');
//           print('Corpo da resposta: ${response.body}');
//           break;
//         }
//       } catch (e) {
//         print(
//           'Erro na requisição Gemini ou processamento: $e. Tentando novamente...',
//         );
//       }
//       if (attempt >= maxRetries) {
//         print(
//           'FALHA GERAL: Não foi possível gerar uma nova pergunta após $maxRetries tentativas.',
//         );
//       }
//     }
//   }

//   void postPerguntaNova(Pergunta nova) async {
//     List<Pergunta> listaPerguntas = await getAll();
//     List<Map<String, dynamic>> listaPerguntasMap = [];
//     for (Pergunta pergunta in listaPerguntas) {
//       listaPerguntasMap.add(pergunta.toMap());
//     }
//     listaPerguntasMap.add(nova.toMap());
//     String content = jsonEncode(listaPerguntasMap);
//     Response response = await post(
//       Uri.parse(ApiConfig.getUrlPerguntas()),
//       headers: _headers,
//       body: json.encode({
//         "description": "perguntas.json",
//         "public": true,
//         "files": {
//           "perguntas.json": {"content": content},
//         },
//       }),
//     );
//     if (response.statusCode.toString()[0] == "2") {
//       print(
//         "${DateTime.now()} | Requisição de gravação bem sucedida ${nova.getQuestao()}",
//       );
//     } else {
//       print("${DateTime.now()} | Requisição falhou ${nova.getQuestao()}");
//     }
//   }
// }