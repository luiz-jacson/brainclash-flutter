import 'package:flutter_brainclash/models/categoria.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriaService {
  Future<List<Categoria>> getAll() async {
    List<Categoria> listCategorias = [];

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('categorias')
          .get();

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        listCategorias.add(
          Categoria(
            data["nome"],
            data["colorHex"],
            data["iconCodePoint"],
            data["imageUrl"],
            doc.id,
          ),
        );
      }
    } catch (Erro) {
      print("ERRO!");
      print(Erro);
    }
    return listCategorias;
  }

  //   void postCategoriaNova(Categoria nova) async {
  //     List<Categoria> listaCategorias = await getall();
  //     List<Map<String, dynamic>> listaCategoriasMap = [];
  //     bool existe = false;

  //     //Lembrar de melhorar a verificação da existencia da categoria
  //     for (Categoria categoria in listaCategorias) {
  //       if (categoria.nome == nova.nome) {
  //         existe = true;
  //       }
  //       listaCategoriasMap.add(categoria.toMap());
  //     }

  //     if (!existe) {
  //       listaCategoriasMap.add(nova.toMap());
  //       String content = jsonEncode(listaCategoriasMap);
  //       Response response = await post(
  //         Uri.parse(ApiConfig.getUrlCategorias()),
  //         headers: _headers,
  //         body: json.encode({
  //           "description": "categorias.json",
  //           "public": true,
  //           "files": {
  //             "categorias.json": {"content": content},
  //           },
  //         }),
  //       );
  //       if (response.statusCode.toString()[0] == "2") {
  //         print(
  //           "${DateTime.now()} | Requisição de gravação bem sucedida ${nova.nome}",
  //         );
  //       } else {
  //         print("${DateTime.now()} | Requisição falhou ${nova.nome}");
  //       }
  //     }

  //     print("Essa categoria já está cadastrada!");
  //   }

  //   Future<void> gerarCategoriaGemini() async {
  //     const int maxRetries = 3;

  //     for (int attempt = 0; attempt < maxRetries; attempt++) {
  //       List<Categoria> existingCategorias = await getall();

  //       List<String> existingCategoryNames = existingCategorias
  //           .map((c) => c.nome)
  //           .toList();
  //       String existingCategoriesString = existingCategoryNames.join(', ');

  //       final String prompt =
  //           '''
  // Gere APENAS o objeto JSON de UMA NOVA categoria para um quiz ou jogo de trivia.
  // A categoria deve ter "idCategoria" (um número inteiro) e "nome" (uma string).
  // A nova categoria NÃO deve se repetir com as seguintes categorias existentes:
  // $existingCategoriesString

  // A resposta deve ser APENAS o objeto JSON e nada mais, SEM TEXTO EXPLICATIVO, SEM MARKDOWN (como ```json).
  // Exemplo de formato: {"nome": "Nova Categoria"}
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
  //               Map<String, dynamic> newCategoryJson = jsonDecode(
  //                 cleanJsonString,
  //               );
  //               Categoria novaCategoriaGerada = Categoria.fromMap(
  //                 newCategoryJson,
  //               );
  //               bool alreadyExists = existingCategorias.any(
  //                 (c) =>
  //                     c.nome.toLowerCase() ==
  //                     novaCategoriaGerada.nome.toLowerCase(),
  //               );

  //               if (alreadyExists) {
  //                 print(
  //                   'AVISO: Gemini gerou uma categoria duplicada: "${novaCategoriaGerada.nome}". Tentando novamente...',
  //                 );
  //                 continue;
  //               }
  //               print(
  //                 'Sucesso! Nova categoria gerada pelo Gemini: ${novaCategoriaGerada.nome}',
  //               );

  //               postCategoriaNova(novaCategoriaGerada);
  //               return;
  //             } on FormatException catch (e) {
  //               print(
  //                 'ERRO DE DECODIFICAÇÃO JSON: $e. String recebida: $cleanJsonString. Tentando novamente...',
  //               );
  //             }
  //           } else {
  //             print(
  //               'Gemini não gerou nenhum texto de categoria. Tentando novamente...',
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
  //           'FALHA GERAL: Não foi possível gerar uma nova categoria após $maxRetries tentativas.',
  //         );
  //       }
  //     }
  //   }
}
