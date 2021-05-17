import 'package:flutter/cupertino.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/services/mock_data_playlist.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:stacked/stacked.dart';

class EditPlaylistViewModel extends BaseViewModel {

  TextEditingController descriptionController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  List<dynamic> selectedGenres = [];

  Playlist playlist;

  MockDataPlaylistService mockdata = locator<MockDataPlaylistService>();

  List<MultiSelectItem<dynamic>> playlistGenre;

  EditPlaylistViewModel(Playlist pl) {
    playlist = pl;
    descriptionController.text = pl.description;
    nameController.text = pl.name;
    playlistGenre = mockdata.genres.map((genre) => MultiSelectItem<dynamic>(genre, genre)).toList();
  }

  void canEdit() {
    playlist.canEdit = !playlist.canEdit;
    notifyListeners();
  }

  void save() {
    playlist.description = descriptionController.text;
    playlist.name = nameController.text;
    playlist.genres = selectedGenres;
    canEdit();
    notifyListeners();
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