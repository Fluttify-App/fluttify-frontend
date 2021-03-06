import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/services/dynamic_link_service.dart';
import 'package:fluttify/services/auth_service.dart';
import 'package:fluttify/services/fluttify_playlist_service.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_item.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditPlaylistViewModel extends BaseViewModel {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();
  final AuthService authService = locator<AuthService>();

  final FluttifyPlaylistService fluttifyPlaylistService =
      locator<FluttifyPlaylistService>();

  List<dynamic> selectedGenres = [];

  List<MultiSelectItem<dynamic>>? playlistGenre;

  Playlist? playlist;

  Timer? _timer;

  bool isChanged = false;

  String lastContributor = "";

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
    if (playlist.allgenres) {
      selectedGenres.add('All Genres');
    }
    notifyListeners();
  }

  void canEdit() {
    playlist!.canEdit = !playlist!.canEdit;
    notifyListeners();
  }

  // TODO: 'All Genres should be visible in view without adding it to playlist.genres'
  void save(BuildContext context) {
    playlist!.description = descriptionController.text;
    playlist!.name = nameController.text;
    if (selectedGenres.contains('All Genres')) {
      selectedGenres.remove('All Genres');
      playlist!.genres = selectedGenres;
    } else {
      playlist!.genres = selectedGenres;
    }
    fluttifyPlaylistService.saveFluttifyPlaylist(playlist!).then((success) {
      if (success) {
        canEdit();
        this.isChanged = true;
      }
    });
  }

  void addGenre(List<dynamic> value) {
    if (value.contains('All Genres')) {
      playlist!.allgenres = true;
      selectedGenres = value;
    } else {
      selectedGenres = value;
      playlist!.allgenres = false;
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
    playlist!.keepAllTracks = value;
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
        snackbarText =
            Text(AppLocalizations.of(context)!.removePlaylistSnackBar);
      } else {
        snackbarText =
            Text(AppLocalizations.of(context)!.couldNotRemoveSnackBar);
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
        content: Text(AppLocalizations.of(context)!.joinedPlaylistSnackBar),
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
        content: Text(AppLocalizations.of(context)!.playlistUpdateSnackBar),
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

  Widget getSongContributors(song) {
    String? contributor = playlist!.currentTracks![song.uri!];
    if (contributor != null && contributor != lastContributor) {
      lastContributor = playlist!.currentTracks![song.uri];
      dynamic contributorName = playlist!.displayContributers!
          .firstWhere((element) => element['id'] == contributor);
      return Row(children: <Widget>[
        Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(contributorName['name']),
        ),
        Expanded(child: Divider()),
      ]);
    } else {
      return Container();
    }
  }
}
