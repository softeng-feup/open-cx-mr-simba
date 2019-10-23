import 'package:ama/json/HttpJsonFetcher.dart';
import 'package:ama/json/PersonJsonMapper.dart';
import 'package:ama/data/Person.dart';
import 'package:test/test.dart';

void main() {
  test('Test', () async {
    final HttpJsonFetcher fetcher = HttpJsonFetcher();
    
    String json = await fetcher.getJson();

    List<Person> people = PersonJsonMapper.fromJsonArray(json);
    expect(293, people.length);
  });
}