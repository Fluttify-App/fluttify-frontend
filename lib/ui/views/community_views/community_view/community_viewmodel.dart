import 'package:flutter/material.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/services/fluttify_playlist_service.dart';
import 'package:fluttify/services/navigation_service.dart';
import 'package:fluttify/ui/views/playlists_views/edit_playlist_views/edit_playlist_view.dart';

import 'package:stacked/stacked.dart';

class CommunityViewModel extends BaseViewModel {
  final FluttifyPlaylistService playlistService =
      locator<FluttifyPlaylistService>();
  final PlaylistNavigationService _navigationService =
      locator<PlaylistNavigationService>();

  bool isLoading = true;

  void refreshCommunityPlaylists() {
    isLoading = true;
    notifyListeners();
    playlistService.getCommunityFluttifyPlaylists().then((playlistsResponse) {
      isLoading = false;
      notifyListeners();
    });
  }

  void navigateBack(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  void navigateToEditPage(Playlist playlist) {
    _navigationService.navigateTo('/edit-playlist',
        EditPlaylistView(playlistId: playlist.dbID!, communityview: true),
        withNavBar: false, callback: (value) {
      if (value != null && value == true) {
        refreshCommunityPlaylists();
      }
    });
  }
}
