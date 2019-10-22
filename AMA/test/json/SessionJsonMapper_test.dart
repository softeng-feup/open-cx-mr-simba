import 'package:ama/data/Session.dart';
import 'package:ama/json/SessionJsonMapper.dart';
import 'package:test/test.dart';
import 'dart:convert';

void main() {
  String json = '{"Chairs":["chair1","otherchair"]}';
  String fullJson = '{"Sessions":[{"Title":"Posters: Poster Session","Items":["programming-2019-posters-idve-an-integrated-development-and-verification-environment-for-javascript","programming-2019-posters-developing-distributed-systems-with-scalaloci","programming-2019-posters-distributed-software-on-mobile-robot","programming-2019-posters-proving-inequational-propositions-about-haskell-programs-in-coq"],"Abstract":"","Type":"Accepted Papers","Key":"a274fbc2-3bc1-4840-a4f1-b6d488e748c1","Day":"2019-04-03","Time":"12:30 - 14:30","Location":"Hotel Bristol Palace | Second floor hall"},{"Title": "Student Research Competition: Oral Presentation","ChairsString":"Philipp Haller","Chairs":["philipphaller"],"Items":["programming-2019-src-cantor-pairing-in-a-reversible-programming-language-short-presentation-","programming-2019-src-reading-logic-as-code-or-as-natural-language-text-short-presentation-","programming-2019-src-a-framework-for-big-step-semantics-short-presentation-","programming-2019-src-rml-runtime-monitoring-language-short-presentation-","programming-2019-src-baccaml-the-meta-hybrid-just-in-time-compiler-short-presentation-","programming-2019-src-magritte-a-modern-shell-language-short-presentation-"],"Abstract":"The ACM Student Research Competition (SRC), sponsored by Microsoft Research, offers a unique forum for ACM student members at the undergraduate and graduate levels to present their original research at \u0026lt;Programming\u0026gt; before a panel of judges and conference attendees, and creates opportunities for learning and networking among researchers and practitioners. The SRC gives visibility to not only up-and-coming young researchers, but also to the field of computer science research and its community.","Type":"Invited Students","Key":"dc03a3e9-5dbd-4af4-973c-0941b84ef00b","Day":"2019-04-03","Time":"09:30 - 11:00","Location":"Hotel Bristol Palace | Bellini"}]}';
  test('Json to string array', () {
    List<String> list = SessionJsonMapper.getStringList(jsonDecode(fullJson), "Chairs");
    assert(list != null);
    expect(2, list.length);
    expect("chair1", list[0]);
    expect("otherchair", list[1]);
  });

  test('Json to sessions array', () {
    print("oupa");
    List<Session> list = SessionJsonMapper.fromJsonArrayMap(jsonDecode(fullJson));
    if (list == null) print("list's null");
    assert(list != null);
    expect(2, list.length);
  });
}