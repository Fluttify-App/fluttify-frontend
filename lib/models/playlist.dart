class Playlist {
  String dbID;
  String id;
  String name;
  String creator;
  String description;
  List<dynamic> contributers;
  bool allgenres;
  List<dynamic> genres;
  String image;
  List<dynamic> collaborators;
  int numberOfSongs;
  bool canEdit = false;

  Playlist(
      {this.dbID, //Database ID
      this.id, // Spotify Playlist ID
      this.name,
      this.creator,
      this.description,
      this.contributers,
      this.allgenres,
      this.genres,
      this.image,
      this.canEdit = false,
      this.numberOfSongs});

  List<Object> get props => [
        dbID,
        id,
        name,
        creator,
        description,
        contributers,
        allgenres,
        genres,
        image,
        canEdit,
        numberOfSongs
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
        canEdit: true,
        numberOfSongs: parsedJson['trackURIs'].length,
        image: "assets/images/spotify.jpg");
  }
}
