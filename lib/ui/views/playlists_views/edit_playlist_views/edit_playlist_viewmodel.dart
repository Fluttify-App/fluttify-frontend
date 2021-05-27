import 'package:flutter/cupertino.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/models/song.dart';
import 'package:fluttify/services/fluttify_playlist_service.dart';
import 'package:fluttify/services/navigation_service.dart';
import 'package:fluttify/services/playlist_service.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_item.dart';
import 'package:stacked/stacked.dart';

class EditPlaylistViewModel extends BaseViewModel {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final PlaylistNavigationService _navigationService =
      locator<PlaylistNavigationService>();
  final PlaylistService playlistService = locator<PlaylistService>();

  final FluttifyPlaylistService fluttifyPlaylistService =
      locator<FluttifyPlaylistService>();

  List<dynamic> selectedGenres = [];

  List<MultiSelectItem<dynamic>>? playlistGenre;

  Playlist? playlist;

  List<Song>? songs;

  EditPlaylistViewModel() {
    playlistGenre = playlistService.genres!
        .map((genre) => MultiSelectItem<dynamic>(genre, genre))
        .toList();
    songs = playlistService.songs;
  }

  void setPlaylist(Playlist playlist) {
    this.playlist = playlist;
    descriptionController.text = playlist.description!;
    nameController.text = playlist.name!;
    notifyListeners();
  }

  void canEdit() {
    playlist!.canEdit = !playlist!.canEdit;
    notifyListeners();
  }

  void save(BuildContext context) {
    playlist!.description = descriptionController.text;
    playlist!.name = nameController.text;
    playlist!.genres = selectedGenres;
    playlistService.playlists!.add(playlist!);
    fluttifyPlaylistService.saveFluttifyPlaylist(playlist!).then((success) {
      if (success) {
        canEdit();
        Navigator.of(context).pop(true);
      }
    });
  }

  void addGenre(List<dynamic> value) {
    selectedGenres = value;
    notifyListeners();
  }

  void removeGenre(String value) {
    selectedGenres.remove(value);
    notifyListeners();
  }

  Future<void> getPlaylist(String playlistId) async {
    Playlist playlist =
        await fluttifyPlaylistService.getFluttifyPlaylist(playlistId);
    setPlaylist(playlist);
  }
}
