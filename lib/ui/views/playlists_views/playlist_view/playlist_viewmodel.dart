import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/services/fluttify_playlist_service.dart';
import 'package:fluttify/services/navigation_service.dart';
import 'package:fluttify/ui/views/add_playlist_views/add_playlist_view.dart';
import 'package:fluttify/ui/views/playlists_views/edit_playlist_views/edit_playlist_view.dart';

import 'package:stacked/stacked.dart';

class PlaylistViewModel extends BaseViewModel {
  final FluttifyPlaylistService playlistService =
      locator<FluttifyPlaylistService>();

  final PlaylistNavigationService _navigationService =
      locator<PlaylistNavigationService>();

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

  void navigateToEditPage(Playlist playlist) {
    _navigationService.navigateTo(
        '/edit-playlist', EditPlaylistView(playlist: playlist),
        withNavBar: false);
  }

  void navigateToAddPlaylist() {
    _navigationService.navigateTo('/edit-playlist', AddPlaylistView(),
        withNavBar: false);
  }
}
