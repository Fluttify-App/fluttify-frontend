import 'package:flutter/cupertino.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/services/fluttify_playlist_service.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_item.dart';
import 'package:stacked/stacked.dart';

class AddPlaylistViewModel extends BaseViewModel {
  final FluttifyPlaylistService fluttifyPlaylistService =
      locator<FluttifyPlaylistService>();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Playlist playlist = Playlist();

  List<dynamic> selectedGenres = [];

  List<MultiSelectItem<dynamic>>? playlistGenre;

  AddPlaylistViewModel() {
    playlistGenre = fluttifyPlaylistService.genres
        .map((genre) => MultiSelectItem<dynamic>(genre, genre))
        .toList();
    playlistGenre!.insert(0, MultiSelectItem('All Genres', 'All Genres'));

    nameController.addListener(notifyListeners);
  }

  void navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  void save(BuildContext context) {
    playlist.name = nameController.text;
    playlist.description = descriptionController.text;
    if (selectedGenres.contains('All Genres'))
      selectedGenres.remove('All Genres');
    playlist.genres = selectedGenres;
    fluttifyPlaylistService.saveFluttifyPlaylist(playlist).then((success) {
      if (success) {
        Navigator.of(context).pop(true);
      }
    });
  }

  void addGenre(List<dynamic> value) {
    if (value.contains('All Genres')) {
      playlist.allgenres = true;
      selectedGenres = value;
    } else {
      selectedGenres = value;
      playlist.allgenres = false;
    }
    notifyListeners();
  }

  void checkAllGenres(List<dynamic> value) {
    if (value.contains('All Genres')) {
      value.removeRange(0, value.length - 1);
    }
    notifyListeners();
  }

  void removeGenre(String value) {
    selectedGenres.remove(value);
    notifyListeners();
  }

  void keepItFresh(bool value) {
    playlist.keepAllTracks = value;
    notifyListeners();
  }
}
