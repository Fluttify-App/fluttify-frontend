import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/models/song.dart';
import 'package:fluttify/services/dynamic_link_service.dart';
import 'package:fluttify/services/auth_service.dart';
import 'package:fluttify/services/fluttify_playlist_service.dart';
import 'package:fluttify/services/navigation_service.dart';
import 'package:fluttify/ui/views/playlists_views/playlist_view/playlist_view.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_item.dart';
import 'package:stacked/stacked.dart';

class EditPlaylistViewModel extends BaseViewModel {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final PlaylistNavigationService _navigationService =
      locator<PlaylistNavigationService>();
  final DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();
  final AuthService authService = locator<AuthService>();

  final FluttifyPlaylistService fluttifyPlaylistService =
      locator<FluttifyPlaylistService>();

  List<dynamic> selectedGenres = [];

  List<MultiSelectItem<dynamic>>? playlistGenre;

  Playlist? playlist;

  Timer? _timer;

  bool isChanged = false;

  EditPlaylistViewModel(Playlist? playlist, String? playlistId) {
    if (playlist != null) {
      setPlaylist(playlist);
    }
    playlistGenre = fluttifyPlaylistService.genres
        .map((genre) => MultiSelectItem<dynamic>(genre, genre))
        .toList();
    playlistGenre!.insert(0, MultiSelectItem('All Genres', 'All Genres'));
    _timer = new Timer.periodic(
        Duration(seconds: 15),
        (Timer timer) => {
              if (this.playlist!.updating!) {getPlaylist(this.playlist!.dbID!)}
            });
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  void setPlaylist(Playlist playlist) {
    this.playlist = playlist;
    descriptionController.text = playlist.description!;
    nameController.text = playlist.name!;
    selectedGenres = playlist.genres!;
    notifyListeners();
  }

  void canEdit() {
    playlist!.canEdit = !playlist!.canEdit;
    notifyListeners();
  }

  void save(BuildContext context) {
    playlist!.description = descriptionController.text;
    playlist!.name = nameController.text;
    if (selectedGenres.contains('All Genres'))
      selectedGenres.remove('All Genres');
    playlist!.genres = selectedGenres;
    fluttifyPlaylistService.saveFluttifyPlaylist(playlist!).then((success) {
      if (success) {
        canEdit();
        this.isChanged = true;
      }
    });
  }

  void addGenre(List<dynamic> value) {
    if (value.contains('All Genres')) {
      playlist!.allgenres = !playlist!.allgenres;
    }
    selectedGenres = value;
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

  Future<void> getPlaylist(String playlistId) async {
    Playlist playlist =
        await fluttifyPlaylistService.getFluttifyPlaylist(playlistId);
    setPlaylist(playlist);
  }

  Future<void> pressShare(String playlistId) async {
    _dynamicLinkService.createFirstPostLink(playlistId);
  }

  Future<void> leavePlaylist(BuildContext context) async {
    fluttifyPlaylistService
        .removeFluttifyPlaylist(this.playlist!)
        .then((value) {
      var snackbarText;
      if (value) {
        snackbarText = Text("Playlist removed from library");
      } else {
        snackbarText = Text("Could not remove playlist");
      }
      Navigator.of(context).pop(true);
      final snackBar = SnackBar(
        content: snackbarText,
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 1500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  Future<void> joinPlaylist(BuildContext context) async {
    fluttifyPlaylistService
        .joinFluttifyPlaylist(this.playlist!)
        .then((playlistUpdate) {
      Navigator.of(context).pop(true);
      final snackBar = SnackBar(
        content: Text("Joined Playlist"),
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 1500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  Future<void> updatePlaylist(BuildContext context) async {
    fluttifyPlaylistService
        .updateFluttifyPlaylist(this.playlist!)
        .then((playlistUpdate) {
      setPlaylist(playlistUpdate);
      final snackBar = SnackBar(
        content: Text("Playlist is getting updated"),
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 1500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  void navigateBack(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop(this.isChanged);
  }

  String getCreator() {
    String creatorName = '';
    playlist!.displayContributers!.forEach((element) {
      if (element['id'] == playlist!.creator) creatorName = element['name'];
    });
    return creatorName == '' ? playlist!.creator! : creatorName;
  }

  void removeUser(String id) {
    playlist!.displayContributers!
        .removeWhere((element) => element['id'] == id);
    playlist!.contributers!.removeWhere((element) => element == id);
    notifyListeners();
  }
}
