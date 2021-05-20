import 'package:flutter/cupertino.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/services/navigation_service.dart';
import 'package:fluttify/services/playlist_service.dart';
import 'package:stacked/stacked.dart';

class AddPlaylistViewModel extends BaseViewModel {
  PlaylistService playlistService = locator<PlaylistService>();
  AddPlaylistNavigationService _navigationService =
      locator<AddPlaylistNavigationService>();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController genreController = TextEditingController();

  Playlist playlist = Playlist();

  void navigateBack() {
    _navigationService.popCurrent(withNavBar: false);
    notifyListeners();
  }

  void save(BuildContext context) {
    playlist.name = nameController.text;
    playlist.description = descriptionController.text;
    playlist.genres = [genreController.text];
    playlistService.playlists!.add(playlist);
    navigateBack();
    //Navigator.of(context).pop();
  }

  void saveName(String value) {
    nameController.text = value;
  }

  void saveDescription(String value) {
    descriptionController.text = value;
  }
}
