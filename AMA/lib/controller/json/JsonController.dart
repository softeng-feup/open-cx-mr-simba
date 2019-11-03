import 'package:http/http.dart' as http;
import 'dart:convert';

class JsonController {
  static final JsonController _jsonController = JsonController._internal();
  Map<String, dynamic> _json;

  factory JsonController() {
    return _jsonController;
  }

  JsonController._internal();

  // TODO: por agora assumindo que o json retorna sempre
  // TODO: verificar que tambem funciona bem quando url e local (para teste)
  Future parseJsonFromURL(String url) async {
    http.Client client;
    http.Response response;

    try {
      client = http.Client();
      response = await client.get(url);
    } catch(e) {
      print(e);
    }

    _json = jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getJson(String url) async {
    if(_json == null)
      await parseJsonFromURL(url);

    return _json;
  }
}