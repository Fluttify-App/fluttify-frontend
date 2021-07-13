import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/services/auth_service.dart';
import 'package:fluttify/services/fluttify_playlist_service.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_item.dart';
import 'package:stacked/stacked.dart';

class DisplayCommunityViewModel extends BaseViewModel {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final AuthService authService = locator<AuthService>();

  final FluttifyPlaylistService fluttifyPlaylistService =
      locator<FluttifyPlaylistService>();

  List<MultiSelectItem<dynamic>>? playlistGenre;

  Playlist? playlist;

  bool isChanged = false;

  DisplayCommunityViewModel() {
    playlistGenre = fluttifyPlaylistService.genres
        .map((genre) => MultiSelectItem<dynamic>(genre, genre))
        .toList();
    playlistGenre!.insert(0, MultiSelectItem('All Genres', 'All Genres'));
  }

  void setPlaylist(Playlist playlist) {
    this.playlist = playlist;
    descriptionController.text = playlist.description!;
    nameController.text = playlist.name!;
    if (playlist.allgenres) {
      playlist.genres!.add('All Genres');
    }
    notifyListeners();
  }

  Future<void> getPlaylist(String playlistId) async {
    Playlist playlist =
        await fluttifyPlaylistService.getFluttifyPlaylist(playlistId);
    setPlaylist(playlist);
  }

  Future<void> likePlaylist(BuildContext context) async {
    fluttifyPlaylistService
        .likeFluttifyPlaylist(this.playlist!)
        .then((playlistUpdate) {
      this.isChanged = true;
      setPlaylist(playlistUpdate);
      final snackBar = SnackBar(
        content: Text("Liked Playlist"),
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 1500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  Future<void> unlikePlaylist(BuildContext context) async {
    fluttifyPlaylistService
        .unlikeFluttifyPlaylist(this.playlist!)
        .then((playlistUpdate) {
      this.isChanged = true;
      setPlaylist(playlistUpdate);
      final snackBar = SnackBar(
        content: Text("Unliked Playlist"),
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
}
