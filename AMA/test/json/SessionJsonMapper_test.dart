import 'package:ama/json/SessionJsonMapper.dart';
import 'package:test/test.dart';
import 'dart:convert';

void main() {
  String json = '{"Name":"André Restivo","Affiliation":"LIACC, Universidade do Porto, Porto, Portugal","Key":"andrerestivo","URL":"https://www.fe.up.pt/~arestivo/","URLphoto":"https://2019.programming-conference.org/getProfileImage/andrerestivo/be9b5e1e-0ea6-4641-83fd-e11d78a087f4/small.jpg"}';
  String fullJson = '{"Chairs":["chair1","otherchair"]}';
  test('Json to string array', () {
    List<String> list = SessionJsonMapper.getStringList(jsonDecode(fullJson), "Chairs");
    assert(list != null);
    expect(2, list.length);
    expect("chair1", list[0]);
    expect("otherchair", list[1]);
  });
}