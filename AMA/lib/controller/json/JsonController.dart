import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../../constants/Utility.dart' as Utility;
import 'dart:convert';

class JsonController {
  static final JsonController _jsonController = JsonController._internal();

  factory JsonController() {
    return _jsonController;
  }

  JsonController._internal();

  // TODO: por agora assumindo que o json retorna sempre (fazer alert a dizer que informacao nao esta disponivel, quando for o caso)
  Future<Map<String, dynamic>> parseJsonFromURL(String url) async {
    Map<String, dynamic> _json;

    // check if there is internet connection
    try {
      await InternetAddress.lookup('google.com');
    } on SocketException catch (_) {
      return null;
    }

    var match = new RegExp(Utility.urlPattern, caseSensitive: false).firstMatch(url);

    if(match != null) { // if url is valid
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
    else { // if json file is local
      _json = jsonDecode(await rootBundle.loadString(url));
    }

    return _json;
  }

}