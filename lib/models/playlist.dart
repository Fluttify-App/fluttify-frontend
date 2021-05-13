class Playlist {
  int id;
  String name;
  String description;
  List<String> genres;
  String image;
  List<String> collaborators; 

  Playlist({
      this.id,
      this.name,
      this.description,
      this.genres,
      this.image,
      this.collaborators
  });
}