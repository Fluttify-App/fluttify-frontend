import 'package:fluttify/models/playlist.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

class PlaylistService {
  List<String> genres = <String>["Rap", "Rock", "Pop", "Hardstyle", "Hardcore"];

  List<String> collaborators = <String>[
    "Sascha",
    "Tom",
    "Phillip",
    "Florian",
    "Patrick"
  ];

  List<Playlist> playlists;

  PlaylistService() {
    playlists = getPlaylists();
  }


  List<Playlist> getPlaylists() {
    List<Playlist> playlists = <Playlist>[];
    for (int i = 0; i < 20; i++) {
      playlists.add(createPlaylistMockup(i));
    }
    return playlists;
  }

  Playlist createPlaylistMockup(int i) {
    Playlist playlist = Playlist();
    playlist.id = i;
    playlist.name = 'Beispiel $i';
    playlist.description = lipsum.createParagraph();
    playlist.genres = genres;
    playlist.image = 'assets/images/spotify.jpg';
    playlist.collaborators = collaborators;
    playlist.numberOfSongs = 100;
    return playlist;
  }
}
