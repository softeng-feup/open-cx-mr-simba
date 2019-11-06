class Item {
  Item({this.key,
        this.title,
        this.type,
        this.url,
        this.peopleString,
        this.authors,
        this.affiliationString,
        this.description});

  // NOTA: foi retirado as affiliations pois elas nao acrescentavam informacao nenhuma
  // (ja se tem a affiliationString)

  String key;
  String title;
  String type;
  String url;
  String peopleString;
  List<String> authors;
  String affiliationString;
  String description;
}