class Item {
  Item({this.key,
        this.title,
        this.type,
        this.url,
        this.peopleString,
        this.authors,
        this.affiliationString,
        this.affiliations,
        this.description});

  String key;
  String title;
  String type;
  String url;
  String peopleString;
  List<String> authors;
  String affiliationString;
  List<String> affiliations;
  String description;
}