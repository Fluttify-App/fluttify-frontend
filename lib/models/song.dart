class Song {
  String? name;
  String? image;
  String? artist;
  String? link;
  Song({this.name, this.image, this.artist, this.link});

  factory Song.fromJson(Map<String, dynamic> parsedJson) {
    return Song(
        name: parsedJson['name'],
        image: parsedJson['image'],
        artist: parsedJson['artist'],
        link: parsedJson['link']);
  }
}
