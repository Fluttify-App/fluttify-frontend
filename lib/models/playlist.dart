class Playlist {
  int id;
  String name;
  String description;
  List<dynamic> genres;
  String image;
  List<String> collaborators; 
  int numberOfSongs;
  bool canEdit = false;

  Playlist({
      this.id,
      this.name,
      this.description,
      this.numberOfSongs,
      this.genres,
      this.image,
      this.collaborators,
      this.canEdit = false
  });
}