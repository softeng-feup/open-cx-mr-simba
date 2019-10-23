import 'package:ama/json/PersonJsonMapper.dart';
import 'package:ama/data/Person.dart';
import 'package:test/test.dart';

void main() {
  String json = '{"Name":"André Restivo","Affiliation":"LIACC, Universidade do Porto, Porto, Portugal","Key":"andrerestivo","URL":"https://www.fe.up.pt/~arestivo/","URLphoto":"https://2019.programming-conference.org/getProfileImage/andrerestivo/be9b5e1e-0ea6-4641-83fd-e11d78a087f4/small.jpg"}';
  String fullJson =  '{"People": [{"Name": "Susan Eisenbach","Affiliation": "Imperial College London","Key": "susaneisenbach","URL": "http://wp.doc.ic.ac.uk/susan/",  "URLphoto": "https://2019.programming-conference.org/getProfileImage/susaneisenbach/000bd12b-5ff6-4b19-a009-a21eee0e0f97/small.jpg"},{"Name": "Matthew Flatt","Affiliation": "University of Utah","Key": "matthewflatt","Bio": "Matthew Flatt is a professor in the School of Computing at the University of Utah, where he works on extensible programming languages, runtime systems, and applications of functional programming. He is one of the developers of the Racket programming language. He received his PhD from Rice University in 1999.","URL": "http://www.cs.utah.edu/~mflatt/","URLphoto": "https://2019.programming-conference.org/getProfileImage/matthewflatt/01508046-0bdb-4eb0-a674-27198f8debd6/small.jpg"}]}';
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

  test('Decode People Array', () {
    List<Person> list = PersonJsonMapper.fromJsonArray(fullJson);
    assert(list != null);
    expect(2, list.length);
    expect("susaneisenbach", list[0].key);
    expect("matthewflatt", list[1].key);
  });
}