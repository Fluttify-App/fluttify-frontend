import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/services/navigation_service.dart';
import 'package:fluttify/services/playlist_service.dart';
import 'package:fluttify/ui/views/add_playlist_views/add_playlist_view.dart';
import 'package:fluttify/ui/views/playlists_views/edit_playlist_views/edit_playlist_view.dart';

import 'package:stacked/stacked.dart';

class PlaylistViewModel extends BaseViewModel {

  final PlaylistService mockdata = locator<PlaylistService>();

  final PlaylistNavigationService _navigationService = locator<PlaylistNavigationService>();

  void navigateToEditPage(Playlist playlist) {
    _navigationService.navigateTo('/edit-playlist', EditPlaylistView(playlist: playlist), withNavBar: false);
  }

  void navigateToAddPlaylist() {
    _navigationService.navigateTo('/edit-playlist', AddPlaylistView(), withNavBar: false);
  }
  
}