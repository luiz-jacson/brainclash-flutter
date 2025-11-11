class Pergunta {
  int _idPergunta;
  String _questao;
  List<String> _respostas;
  String _respostaCorreta;
  int _idCategoria;

  Pergunta(
    this._idPergunta,
    this._questao,
    this._respostas,
    this._respostaCorreta,
    this._idCategoria,
  );

  int getIdPergunta() {
    return _idPergunta;
  }

  setIdPergunta(int idPergunta) {
    _idPergunta = idPergunta;
  }

  String getQuestao() {
    return _questao;
  }

  setQuestao(String questao) {
    _questao = questao;
  }

  List<String> getRespostas() {
    return _respostas;
  }

  setRespostas(List<String> respostas) {
    _respostas = respostas;
  }

  int getCategorias() {
    return _idCategoria;
  }

  setCategorias(int categoria) {
    _idCategoria = categoria;
  }

  String getRespostaCorreta() {
    return _respostaCorreta;
  }

  setRespostaCorreta(String respostaCorreta) {
    _respostaCorreta = respostaCorreta;
  }

  bool verificaResposta(String resposta) {
    if (resposta != getRespostaCorreta()) {
      return false;
    }
    return true;
  }

  Map<String, dynamic> toMap() {
    return {
      "idPergunta": _idPergunta,
      "questao": _questao,
      "respostas": _respostas,
      "respostaCorreta": _respostaCorreta,
      "idCategoria": _idCategoria,
    };
  }

  factory Pergunta.fromMap(Map<String, dynamic> map) {
    return Pergunta(map["idPergunta"], map["questao"], List<String>.from(map["respostas"] as List) ,map["respostaCorreta"],map["idCategoria"]);
  }
}