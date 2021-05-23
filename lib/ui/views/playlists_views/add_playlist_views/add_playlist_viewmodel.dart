import 'package:flutter/cupertino.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/services/fluttify_playlist_service.dart';
import 'package:fluttify/services/navigation_service.dart';
import 'package:fluttify/services/playlist_service.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_item.dart';
import 'package:stacked/stacked.dart';

class AddPlaylistViewModel extends BaseViewModel {
  PlaylistService playlistService = locator<PlaylistService>();
  PlaylistNavigationService _navigationService =
      locator<PlaylistNavigationService>();

  final FluttifyPlaylistService fluttifyPlaylistService =
      locator<FluttifyPlaylistService>();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Playlist playlist = Playlist();

  List<dynamic> selectedGenres = [];

  List<MultiSelectItem<dynamic>>? playlistGenre;

  AddPlaylistViewModel() {
    playlistGenre = playlistService.genres!
        .map((genre) => MultiSelectItem<dynamic>(genre, genre))
        .toList();
  }

  void navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  void save(BuildContext context) {
    playlist.name = nameController.text;
    playlist.description = descriptionController.text;
    playlist.genres = selectedGenres;
    fluttifyPlaylistService.saveFluttifyPlaylist(playlist).then((success) {
      if (success) {
        Navigator.of(context).pop(true);
      }
    });
    playlistService.playlists!.add(playlist);
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
