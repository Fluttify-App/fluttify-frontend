import 'package:flutter/cupertino.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/services/fluttify_playlist_service.dart';
import 'package:fluttify/services/navigation_service.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_item.dart';
import 'package:stacked/stacked.dart';

class AddPlaylistViewModel extends BaseViewModel {
  PlaylistNavigationService _navigationService =
      locator<PlaylistNavigationService>();

  final FluttifyPlaylistService fluttifyPlaylistService =
      locator<FluttifyPlaylistService>();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Playlist playlist = Playlist();

  List<dynamic> selectedGenres = [];

  Color? chipColor;

  Color? selectedColor;

  List<MultiSelectItem<dynamic>>? playlistGenre;

  AddPlaylistViewModel() {
    chipColor = Color.fromARGB(255, 203, 45, 62);
    selectedColor = Color.fromARGB(255, 203, 45, 62);
    playlistGenre = fluttifyPlaylistService.genres
        .map((genre) => MultiSelectItem<dynamic>(genre, genre))
        .toList();
    playlistGenre!.insert(0, MultiSelectItem('All Genres', 'All Genres'));
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
  }

  void setAllGenres(bool allgenres) {
    playlist.allgenres = allgenres;
    notifyListeners();
  }

  void addGenre(List<dynamic> value) {
    if (value.contains('All Genres')) {
      playlist.allgenres = !playlist.allgenres;
      chipColor = Color(0xff8AAB21);
    }
    selectedGenres = value;
    notifyListeners();
  }

  void checkAllGenres(List<dynamic> value) {
    if (value.contains('All Genres')) {
      value.removeRange(0, value.length - 1);
      selectedColor = Color(0xff8AAB21);
    }
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

  void keepItFresh(bool value) {
    playlist.keepItFresh = value;
    notifyListeners();
  }
}
