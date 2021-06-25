class Song {
  String? uri;
  String? name;
  String? image;
  String? artist;
  String? link;
  Song({this.uri, this.name, this.image, this.artist, this.link});

  factory Song.fromJson(Map<String, dynamic> parsedJson) {
    return Song(
        uri: parsedJson['uri'],
        name: parsedJson['name'],
        image: parsedJson['image'],
        artist: parsedJson['artist'],
        link: parsedJson['link']);
  }
}
