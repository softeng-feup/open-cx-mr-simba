import 'dart:core';

class Item {
  Item({this.key,
        this.title,
        this.type,
        this.url,
        this.peopleString,
        this.authors,
        this.affiliationString,
        this.description});

  String key;
  String title;
  String type;
  String url;
  String peopleString;
  List<String> authors;
  String affiliationString;
  String description;


  // passar uma lista de mapas que e um join entre Item e ItemAuthor
  Item.fromMap(List<Map<String, dynamic>> mapList) {
    this.key = mapList.elementAt(0)['itemKey'];
    this.title = mapList.elementAt(0)['title'];
    this.type = mapList.elementAt(0)['type'];
    this.url = mapList.elementAt(0)['url'];
    this.peopleString = mapList.elementAt(0)['peopleString'];
    this.affiliationString = mapList.elementAt(0)['affiliations'];
    this.description = mapList.elementAt(0)['description'];
    this.authors = [];
    for(int i = 0; i < mapList.length; i++) {
      this.authors.add(mapList.elementAt(i)['personKey']);
    }
  }

  // retorna uma lista de maps cujo primeiro elemento e o item em si e os seguintes sao entradas de ItemAuthor
  List<Map<String, dynamic>> toMap() {
    var itemMap = <String, dynamic>{
      'itemKey': this.key,
      'title': this.title,
      'type': this.type,
      'url': this.url,
      'peopleString': this.peopleString,
      'affiliations': this.affiliationString,
      'description': this.description
    };
    List<Map<String, dynamic>> mapList = [];
    mapList.add(itemMap);
    for(int i = 0; i < this.authors.length; i++) {
      var itemAuthorMap = <String, dynamic>{
        'itemKey': this.key,
        'personKey': this.authors.elementAt(i)
      };
      mapList.add(itemAuthorMap);
    }
    return mapList;
  }

}