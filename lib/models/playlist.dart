import 'dart:convert';

import 'package:fluttify/models/song.dart';

class Playlist {
  String? dbID;
  String? id;
  String? name;
  String? creator;
  String? description;
  List<dynamic>? contributers;
  List<dynamic>? displayContributers;
  dynamic allgenres;
  List<dynamic>? genres;
  String? image;
  int? numberOfSongs;
  bool canEdit;
  List<Song>? songs;

  Playlist(
      {this.dbID, //Database ID
      this.id, // Spotify Playlist ID
      this.name,
      this.creator,
      this.description,
      this.contributers,
      this.displayContributers,
      this.allgenres = false,
      this.genres,
      this.image,
      this.canEdit = false,
      this.numberOfSongs,
      this.songs});

  List<Object> get props => [
        dbID!,
        id!,
        name!,
        creator!,
        description!,
        contributers!,
        displayContributers!,
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
        description: parsedJson['description'],
        contributers: parsedJson['contributers'],
        displayContributers: parsedJson['display_contributers'],
        allgenres: parsedJson['allgenres'],
        genres: parsedJson['genres'],
        canEdit: false,
        numberOfSongs: parsedJson['trackURIs'].length,
        image: parsedJson['images'].length != 0
            ? parsedJson['images'][0]['url']
            : null);
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
