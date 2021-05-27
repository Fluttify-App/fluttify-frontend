import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/services/dynamic_link_service.dart';
import 'package:fluttify/services/fluttify_playlist_service.dart';
import 'package:fluttify/services/playlist_service.dart';
import 'package:fluttify/services/navigation_service.dart';
import 'package:fluttify/ui/views/playlists_views/add_playlist_views/add_playlist_view.dart';
import 'package:fluttify/ui/views/playlists_views/edit_playlist_views/edit_playlist_view.dart';

import 'package:stacked/stacked.dart';

class PlaylistViewModel extends BaseViewModel {
  final FluttifyPlaylistService playlistService =
      locator<FluttifyPlaylistService>();
  final PlaylistNavigationService _navigationService =
      locator<PlaylistNavigationService>();
  final PlaylistService mockplaylistService = locator<PlaylistService>();
  final DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();

  bool isLoading = true;

  void refreshPlaylists() {
    isLoading = true;
    notifyListeners();
    playlistService.refreshFluttifyPlaylists().then((playlistsResponse) {
      isLoading = false;
      notifyListeners();
    });
  }

  void navigateToEditPage(Playlist playlist) {
    _navigationService.navigateTo(
        '/edit-playlist', EditPlaylistView(playlist.dbID!, playlist),
        withNavBar: false, callback: (value) {
      if (value != null) {
        refreshPlaylists();
      }
    });
  }

  void navigateToAddPlaylist() {
    _navigationService.navigateTo('/add-playlist', AddPlaylistView(),
        withNavBar: false, callback: (value) {
      if (value != null) {
        refreshPlaylists();
      }
    });
  }

  void dismissPlaylist(Playlist playlist, context) {
    playlistService.removeFluttifyPlaylist(playlist).then((value) {
      var snackbarText;
      if (value) {
        snackbarText = Text("Plalyist removed from library");
      } else {
        snackbarText = Text("Could not remove playlist");
      }
      refreshPlaylists();
      final snackBar = SnackBar(
        content: snackbarText,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  Future<void> pressShare(String playlistId) async {
    _dynamicLinkService.createFirstPostLink(playlistId);
  }
}
