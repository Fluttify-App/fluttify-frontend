import 'package:intl/intl.dart';

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
  String? href;
  String? image;
  int? numberOfSongs;
  bool canEdit;
  List<Song>? songs;
  List<dynamic>? likes;
  DateTime? lastUpdate;
  bool? updating;
  dynamic keepAllTracks;
  dynamic currentTracks;
  int? countToptracksLong;
  int? countToptracksMedium;
  int? countToptracksShort;
  int? countLibtracks;

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
      this.href,
      this.canEdit = false,
      this.numberOfSongs,
      this.songs,
      this.likes,
      this.lastUpdate,
      this.updating,
      this.keepAllTracks = false,
      this.currentTracks,
      this.countToptracksLong = 0,
      this.countToptracksMedium = 3,
      this.countToptracksShort = 5,
      this.countLibtracks = 5});

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
        href!,
        canEdit,
        numberOfSongs!,
        songs!,
        likes!,
        lastUpdate!,
        updating!,
        currentTracks,
        countToptracksLong!,
        countToptracksMedium!,
        countToptracksShort!,
        countLibtracks!
      ];

  factory Playlist.fromJson(Map<String, dynamic> parsedJson) {
    List<Song> playlistSongs = [];
    if (parsedJson['playlistTracks'] != null) {
      playlistSongs = (parsedJson['playlistTracks'] as List)
          .map((song) => Song.fromJson(song))
          .toList();
    }
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
      href: parsedJson['href'],
      canEdit: false,
      numberOfSongs: parsedJson['totalTracks'],
      songs: playlistSongs,
      likes: parsedJson['likes'],
      lastUpdate: parsedJson['lastUpdate'] != null
          ? DateFormat('yyyy-MM-ddThh:mm:sssZ').parse(parsedJson['lastUpdate'])
          : null,
      image: parsedJson['images'].length != 0
          ? parsedJson['images'][0]['url']
          : null,
      updating: parsedJson['updating'],
      keepAllTracks: parsedJson['keepAllTracks'],
      currentTracks: parsedJson['currentTracks'],
      countToptracksLong: parsedJson['toptracks_long'] ?? 0,
      countToptracksMedium: parsedJson['toptracks_medium'],
      countToptracksShort: parsedJson['toptracks_short'],
      countLibtracks: parsedJson['libtracks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": this.dbID,
      "creator": this.creator,
      "name": this.name,
      "description": this.description,
      "genres": this.genres,
      "allgenres": this.allgenres,
      "contributers": this.contributers,
      "keepAllTracks": this.keepAllTracks,
      "toptracks_short": this.countToptracksShort,
      "toptracks_medium": this.countToptracksMedium,
      "toptracks_long": this.countToptracksLong,
      "libtracks": this.countLibtracks
    };
  }
}
