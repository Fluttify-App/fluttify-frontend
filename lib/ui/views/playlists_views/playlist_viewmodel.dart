import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/services/fluttify_playlist_service.dart';
import 'package:fluttify/services/mock_data_playlist.dart';
import 'package:fluttify/ui/views/playlists_views/playlist_view.dart';
import 'package:stacked/stacked.dart';

class PlaylistViewModel extends BaseViewModel {
  final FluttifyPlaylistService playlistService =
      locator<FluttifyPlaylistService>();

  bool isLoading = true;

  List<Playlist> playlists = <Playlist>[Playlist()];

  PlaylistViewModel() {
    playlistService.getFluttifyPlaylists().then((playlistsResponse) {
      playlists = playlistsResponse;
      isLoading = false;
      print(playlists);
      notifyListeners();
    });
  }
}
