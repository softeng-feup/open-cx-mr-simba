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

  Map<String, dynamic> getJson() {
    return _json;
  }
}