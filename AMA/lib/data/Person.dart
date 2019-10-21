class Person {
  final String key;
  final String name;
  final String affiliation;
  final String bio;
  final String url;
  final String imageURL; // use Image.network(linkFromJSONFile)
  
  Person(this.key, this.name, this.affiliation, this.bio, this.url, this.imageURL);
}