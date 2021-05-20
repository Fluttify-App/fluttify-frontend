import 'package:fluttify/models/playlist.dart';

class PlaylistService {
  List<String> genres = <String>["Rap", "Rock", "Pop", "Hardstyle", "Hardcore"];

  List<String> contributers = <String>[
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
    playlist.id = "i" + i.toString();
    playlist.name = 'Beispiel $i';
    playlist.description =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla tempor, tellus vitae varius ornare, justo mauris auctor justo, eu semper eros quam eu elit. Aenean quis mauris vel ante lobortis ornare ac eu lorem. Praesent leo urna, ornare non nibh at, ullamcorper dapibus nisl. Nulla et mauris congue diam porta sodales. Vivamus varius turpis nisl, sed feugiat sem hendrerit nec. Maecenas bibendum sem augue, volutpat mattis nunc aliquet ac. Duis convallis metus quis bibendum malesuada. Donec egestas dapibus tincidunt. Cras eu porttitor sapien, nec eleifend massa. In hac habitasse platea dictumst. Nullam scelerisque volutpat accumsan. Nam nec euismod nunc, non ultricies est. Aliquam volutpat et enim tristique imperdiet. Nullam tempus iaculis dui eget maximus. Sed quis urna arcu.';
    playlist.genres = genres;
    playlist.image = 'assets/images/spotify.jpg';
    playlist.contributers = contributers;
    playlist.numberOfSongs = 100;
    return playlist;
  }
}
