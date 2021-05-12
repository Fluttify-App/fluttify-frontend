
import 'package:fluttify/models/playlist.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

class MockDataPlaylistService {

  List<String> genres = <String>["Rap", "Rock", "Pop", "Hardstyle"];

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
    playlist.genres = List<String>.filled(5, "Rock");
    playlist.image = 'assets/images/spotify.jpg';
    playlist.genre = genres;
    return playlist;
  }
}