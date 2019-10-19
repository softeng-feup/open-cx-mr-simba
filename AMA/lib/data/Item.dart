class Item {
  Item({this.key,
        this.title,
        this.type,
        this.url,
        this.authorStrings,
        this.authorKeys,
        this.affiliations,
        this.description});

  String key;
  String title;
  String type;
  String url;
  List<String> authorStrings;
  List<String> authorKeys;
  String affiliations;
  String description;

}