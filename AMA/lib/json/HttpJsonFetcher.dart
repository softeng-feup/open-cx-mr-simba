import 'package:http/http.dart' as http;


class HttpJsonFetcher {
  Future<String> getJson() async {
    final http.Client client = http.Client();
    final response = await client.get('https://2019.programming-conference.org/dataexport/810b23a0-737b-4f74-9170-75d515274859/confero.json');

    return response.body;
  }
}
