import 'dart:convert';

class Playlist {
  String? dbID;
  String? id;
  String? name;
  String? creator;
  String? description;
  List<dynamic>? contributers;
  dynamic allgenres;
  List<dynamic>? genres;
  String? image;
  int? numberOfSongs;
  bool canEdit;

  Playlist(
      {this.dbID, //Database ID
      this.id, // Spotify Playlist ID
      this.name,
      this.creator,
      this.description,
      this.contributers,
      this.allgenres = false,
      this.genres,
      this.image,
      this.canEdit = false,
      this.numberOfSongs});

  List<Object> get props => [
        dbID!,
        id!,
        name!,
        creator!,
        description!,
        contributers!,
        allgenres,
        genres!,
        image!,
        canEdit,
        numberOfSongs!
      ];

  factory Playlist.fromJson(Map<String, dynamic> parsedJson) {
    return Playlist(
        dbID: parsedJson['_id'],
        id: parsedJson['id'],
        name: parsedJson['name'],
        creator: parsedJson['creator'],
        description: "bla",
        contributers: parsedJson['contributers'],
        allgenres: parsedJson['allgenres'],
        genres: parsedJson['genres'],
        canEdit: false,
        numberOfSongs: parsedJson['trackURIs'].length);
        //image: "assets/images/spotify.jpg");
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": this.dbID,
      "creator": this.creator,
      "name": this.name,
      "description": this.description,
      "genres": this.genres,
      "allgenres": this.allgenres
    };
  }
}
