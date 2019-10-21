import 'package:ama/json/HttpJsonFetcher.dart';
import 'package:test/test.dart';

void main() {
  test('Test', () async {
    final HttpJsonFetcher fetcher = HttpJsonFetcher();
    
    String json = await fetcher.getJson();
    print(json);
  });
}