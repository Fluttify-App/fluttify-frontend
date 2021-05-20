import 'package:flutter/cupertino.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/services/navigation_service.dart';
import 'package:fluttify/services/playlist_service.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:stacked/stacked.dart';

class AddPlaylistViewModel extends BaseViewModel {
  PlaylistService playlistService = locator<PlaylistService>();
  PlaylistNavigationService _navigationService =
      locator<PlaylistNavigationService>();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController genreController = TextEditingController();

  Playlist playlist = Playlist();

  List<dynamic> selectedGenres = [];

  List<MultiSelectItem<dynamic>>? playlistGenre;

  AddPlaylistViewModel() {
    playlistGenre = playlistService.genres!
        .map((genre) => MultiSelectItem<dynamic>(genre, genre))
        .toList();
  }

  void navigateBack() {
    _navigationService.popCurrent(withNavBar: false);
  }

  void save(BuildContext context) {
    playlist.name = nameController.text;
    playlist.description = descriptionController.text;
    playlist.genres = selectedGenres;
    playlistService.playlists!.add(playlist);
    //navigateBack();
    Navigator.of(context).pop();
  }

  void addGenre(List<dynamic> value) {
    selectedGenres = value;
    notifyListeners();
  }

  void removeGenre(String value) {
    selectedGenres.remove(value);
    notifyListeners();
  }

  void saveName(String value) {
    nameController.text = value;
  }

  void saveDescription(String value) {
    descriptionController.text = value;
  }
}