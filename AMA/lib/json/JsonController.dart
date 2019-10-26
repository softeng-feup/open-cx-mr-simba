import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JsonController {
  static final JsonController _jsonController = JsonController._internal();
  Map<String, dynamic> _json;

  factory JsonController() {
    return _jsonController;
  }

  JsonController._internal();

  Future parseJsonFromURL(String url) async {
    http.Client client;
    http.Response response;

    try {
      client = http.Client();
      response = await client.get(url);
    } catch (e) {
      print(e);
    }

    _json = jsonDecode(response.body);
  }

  Future parseLocalJson(String path) async {
    String jsonString;

    try {
      jsonString = await rootBundle.loadString(path);
    } catch (e) {
      print(e);
    }

    _json = jsonDecode(jsonString);
  }

  Map<String, dynamic> getJson() {
    return _json;
  }
}