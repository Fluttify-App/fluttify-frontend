import 'package:flutter/cupertino.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/services/navigation_service.dart';
import 'package:fluttify/services/playlist_service.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:stacked/stacked.dart';

class EditPlaylistViewModel extends BaseViewModel {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final PlaylistNavigationService _navigationService =
      locator<PlaylistNavigationService>();
  final PlaylistService playlistService = locator<PlaylistService>();

  List<dynamic> selectedGenres = [];

  List<MultiSelectItem<dynamic>> playlistGenre;

  Playlist playlist;

  EditPlaylistViewModel(Playlist pl) {
    playlist = pl;
    descriptionController.text = pl.description;
    nameController.text = pl.name;
    playlistGenre = playlistService.genres
        .map((genre) => MultiSelectItem<dynamic>(genre, genre))
        .toList();
  }

  void canEdit() {
    playlist.canEdit = !playlist.canEdit;
    notifyListeners();
  }

  void save() {
    playlist.description = descriptionController.text;
    playlist.name = nameController.text;
    playlist.genres = selectedGenres;
    // TODO: send save to backend
    //playlistService.playlists[playlist.id] = playlist;
    canEdit();
  }

  void addGenre(List<dynamic> value) {
    selectedGenres = value;
    notifyListeners();
  }

  void removeGenre(String value) {
    selectedGenres.remove(value);
    notifyListeners();
  }
}
