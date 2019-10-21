import 'package:ama/json/PersonJsonMapper.dart';
import 'package:ama/data/Person.dart';
import 'package:test/test.dart';

void main() {
  String json = '{"Name":"André Restivo","Affiliation":"LIACC, Universidade do Porto, Porto, Portugal","Key":"andrerestivo","URL":"https://www.fe.up.pt/~arestivo/","URLphoto":"https://2019.programming-conference.org/getProfileImage/andrerestivo/be9b5e1e-0ea6-4641-83fd-e11d78a087f4/small.jpg"}';

  test('Decode Person', () {
    Person p = PersonJsonMapper.fromJson(json);
    assert(p != null);
    expect(p.name, "André Restivo");
    expect(p.affiliation, "LIACC, Universidade do Porto, Porto, Portugal");
    expect(p.key, "andrerestivo");
    expect(p.url, "https://www.fe.up.pt/~arestivo/");
    expect(p.imageURL, "https://2019.programming-conference.org/getProfileImage/andrerestivo/be9b5e1e-0ea6-4641-83fd-e11d78a087f4/small.jpg");
    expect(p.bio, null);
  });
}