import 'dart:collection';

import 'package:ama/json1/JsonMapper.dart';
import 'package:ama/model/Person.dart';
import 'package:ama/model/Session.dart';
import 'package:test/test.dart';
import 'dart:convert';

main() {
  String person = '{"Name":"André Restivo","Affiliation":"LIACC, Universidade do Porto, Porto, Portugal","Key":"andrerestivo","URL":"https://www.fe.up.pt/~arestivo/","URLphoto":"https://2019.programming-conference.org/getProfileImage/andrerestivo/be9b5e1e-0ea6-4641-83fd-e11d78a087f4/small.jpg"}';
  String people =  '{"People": [{"Name": "Susan Eisenbach","Affiliation": "Imperial College London","Key": "susaneisenbach","URL": "http://wp.doc.ic.ac.uk/susan/",  "URLphoto": "https://2019.programming-conference.org/getProfileImage/susaneisenbach/000bd12b-5ff6-4b19-a009-a21eee0e0f97/small.jpg"},{"Name": "Matthew Flatt","Affiliation": "University of Utah","Key": "matthewflatt","Bio": "Matthew Flatt is a professor in the School of Computing at the University of Utah, where he works on extensible programming languages, runtime systems, and applications of functional programming. He is one of the developers of the Racket programming language. He received his PhD from Rice University in 1999.","URL": "http://www.cs.utah.edu/~mflatt/","URLphoto": "https://2019.programming-conference.org/getProfileImage/matthewflatt/01508046-0bdb-4eb0-a674-27198f8debd6/small.jpg"}]}';
  String stringArray = '{"Chairs":["chair1","otherchair"]}';
  String sessions = '{"Sessions":[{"Title":"Posters: Poster Session","Items":["programming-2019-posters-idve-an-integrated-development-and-verification-environment-for-javascript","programming-2019-posters-developing-distributed-systems-with-scalaloci","programming-2019-posters-distributed-software-on-mobile-robot","programming-2019-posters-proving-inequational-propositions-about-haskell-programs-in-coq"],"Abstract":"","Type":"Accepted Papers","Key":"a274fbc2-3bc1-4840-a4f1-b6d488e748c1","Day":"2019-04-03","Time":"12:30 - 14:30","Location":"Hotel Bristol Palace | Second floor hall"},{"Title": "Student Research Competition: Oral Presentation","ChairsString":"Philipp Haller","Chairs":["philipphaller"],"Items":["programming-2019-src-cantor-pairing-in-a-reversible-programming-language-short-presentation-","programming-2019-src-reading-logic-as-code-or-as-natural-language-text-short-presentation-","programming-2019-src-a-framework-for-big-step-semantics-short-presentation-","programming-2019-src-rml-runtime-monitoring-language-short-presentation-","programming-2019-src-baccaml-the-meta-hybrid-just-in-time-compiler-short-presentation-","programming-2019-src-magritte-a-modern-shell-language-short-presentation-"],"Abstract":"The ACM Student Research Competition (SRC), sponsored by Microsoft Research, offers a unique forum for ACM student members at the undergraduate and graduate levels to present their original research at \u0026lt;Programming\u0026gt; before a panel of judges and conference attendees, and creates opportunities for learning and networking among researchers and practitioners. The SRC gives visibility to not only up-and-coming young researchers, but also to the field of computer science research and its community.","Type":"Invited Students","Key":"dc03a3e9-5dbd-4af4-973c-0941b84ef00b","Day":"2019-04-03","Time":"09:30 - 11:00","Location":"Hotel Bristol Palace | Bellini"}]}';
  String session = '{"Title":"Student Research Competition: Oral Presentation","ChairsString":"Philipp Haller","Chairs":[  "philipphaller"],"Items":["programming-2019-src-cantor-pairing-in-a-reversible-programming-language-short-presentation-","programming-2019-src-reading-logic-as-code-or-as-natural-language-text-short-presentation-","programming-2019-src-a-framework-for-big-step-semantics-short-presentation-","programming-2019-src-rml-runtime-monitoring-language-short-presentation-","programming-2019-src-baccaml-the-meta-hybrid-just-in-time-compiler-short-presentation-","programming-2019-src-magritte-a-modern-shell-language-short-presentation-"],"Abstract":"The ACM Student Research Competition (SRC), sponsored by Microsoft Research, offers a unique forum for ACM student members at the undergraduate and graduate levels to present their original research at \u0026lt;Programming\u0026gt; before a panel of judges and conference attendees, and creates opportunities for learning and networking among researchers and practitioners. The SRC gives visibility to not only up-and-coming young researchers, but also to the field of computer science research and its community.","Type":"Invited Students","Key":"dc03a3e9-5dbd-4af4-973c-0941b84ef00b","Day": "2019-04-03","Time":"09:30 - 11:00","Location": "Hotel Bristol Palace | Bellini"}';

  test('Decode Person', () {
    Person p = JsonMapper.person(jsonDecode(person));
    assert(p != null);
    expect(p.name, "André Restivo");
    expect(p.affiliation, "LIACC, Universidade do Porto, Porto, Portugal");
    expect(p.key, "andrerestivo");
    expect(p.url, "https://www.fe.up.pt/~arestivo/");
    expect(p.imageURL, "https://2019.programming-conference.org/getProfileImage/andrerestivo/be9b5e1e-0ea6-4641-83fd-e11d78a087f4/small.jpg");
    expect(p.bio, null);
  });

  test('Decode People', () {
    Map<String, Person> map = JsonMapper.personMap(jsonDecode(people));
    assert(map != null);
    expect(2, map.length);
    expect("susaneisenbach", map["susaneisenbach"].key);
    expect("matthewflatt", map["matthewflatt"].key);
  });

  test('Decode String array', () {
    List<String> list = JsonMapper.stringList(jsonDecode(stringArray), "Chairs");
    assert(list != null);
    expect(2, list.length);
    expect("chair1", list[0]);
    expect("otherchair", list[1]);
  });

  test('Decode Session', () {
    Session s = JsonMapper.session(jsonDecode(session));
    assert(s != null);
    print(s.startTime);
  });

  test('Decode Sessions', () {
    SplayTreeSet<Session> set = JsonMapper.sessionSet(jsonDecode(sessions), "2019-04-03");

    assert(set != null);
    expect(2, set.length);
  });
}