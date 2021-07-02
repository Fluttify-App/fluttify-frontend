import 'package:flutter/cupertino.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/services/navigation_service.dart';
import 'package:fluttify/ui/views/playlists_views/edit_playlist_views/edit_playlist_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HomeViewModel extends BaseViewModel {
  final PlaylistNavigationService _playlistNavigation =
      locator<PlaylistNavigationService>();
  final CommunityNavigationService _addPlaylistNavigation =
      locator<CommunityNavigationService>();
  final SettingsNavigationService _friendsNavigation =
      locator<SettingsNavigationService>();

  /// Define the navigators you want to get popped to initial when you switch to another tab
  void resetOnItemchange(int index) {
    switch (index) {
      case 0:
        popAllNavigators();
        break;
      case 1:
        popAllNavigators();
        break;
      case 2:
        popAllNavigators();
        break;
      case 3:
        popAllNavigators();
        break;
      case 4:
        popAllNavigators();
        break;
      default:
        popAllNavigators();
        break;
    }
  }

  /// Pops all 5 Navigators to the initial route
  void popAllNavigators() {
    _playlistNavigation.popAll();
    _addPlaylistNavigation.popAll();
    _friendsNavigation.popAll();
  }

  Future<void> routeInWeb(context) async {
    if (kIsWeb) {
      SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
      String? playlistId = sharedPrefs.getString("playlist");
      if (playlistId != null && playlistId != "") {
        sharedPrefs.setString("playlist", "");
        _playlistNavigation.navigateTo(
            '/edit-playlist', EditPlaylistView(playlistId: playlistId),
            withNavBar: false);
      }
    }
    return;
  }
}
