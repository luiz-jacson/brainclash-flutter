import 'package:flutter_brainclash/config/api_key.dart';

class ApiConfig {
  static final String _urlCategorias = "https://api.github.com/gists/7c20e2ce03b71c4b1a27a01e3e9bd6b8";
  static final String _urlPerguntas = "https://api.github.com/gists/3db606b2264cf25a9902c99f6d775858";
  static final String _apiGeminiKey = apiGeminiKey;
  static final String _apiGeminiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$_apiGeminiKey';


  ApiConfig._();

  static String getUrlCategorias() => _urlCategorias;
  static String getUrlPerguntas() => _urlPerguntas;
  static String apiGemini() => _apiGeminiUrl;

}