import 'package:flutter/cupertino.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/services/navigation_service.dart';
import 'package:fluttify/ui/views/playlists_views/edit_playlist_views/edit_playlist_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HomeViewModel extends BaseViewModel {
  final PersistentTabController controller =
      PersistentTabController(initialIndex: 0);

  final PlaylistNavigationService _playlistNavigation =
      locator<PlaylistNavigationService>();
  final CommunityNavigationService _addPlaylistNavigation =
      locator<CommunityNavigationService>();
  final SettingsNavigationService _friendsNavigation =
      locator<SettingsNavigationService>();

  void detectSwipe(DragEndDetails details) {
    if (details.velocity.pixelsPerSecond.dx < 0 && controller.index > 0) {
      controller.index--;
    } else if (details.velocity.pixelsPerSecond.dx > 0 &&
        controller.index < 2) {
      controller.index++;
    }
  }

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
