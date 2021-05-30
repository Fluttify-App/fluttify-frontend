import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/services/dynamic_link_service.dart';
import 'package:fluttify/services/fluttify_playlist_service.dart';
import 'package:fluttify/services/playlist_service.dart';
import 'package:fluttify/services/navigation_service.dart';
import 'package:fluttify/ui/views/community_views/display_community_view/display_community_view.dart';
import 'package:fluttify/ui/views/playlists_views/add_playlist_views/add_playlist_view.dart';
import 'package:fluttify/ui/views/playlists_views/edit_playlist_views/edit_playlist_view.dart';
import 'package:fluttify/ui/views/playlists_views/playlist_view/playlist_view.dart';

import 'package:stacked/stacked.dart';

class CommunityViewModel extends BaseViewModel {
  final FluttifyPlaylistService playlistService =
      locator<FluttifyPlaylistService>();
  final PlaylistNavigationService _navigationService =
      locator<PlaylistNavigationService>();
  final PlaylistService mockplaylistService = locator<PlaylistService>();
  final DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();

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
    _navigationService.navigateTo(
        '/display-community', DisplayCommunityView(playlistId: playlist.dbID!),
        withNavBar: false, callback: (value) {
      if (value != null) {
        refreshCommunityPlaylists();
      }
    });
  }
}
