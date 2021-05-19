
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/services/navigation_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  
  final PlaylistNavigationService _playlistNavigation = locator<PlaylistNavigationService>();
  final AddPlaylistNavigationService _addPlaylistNavigation = locator<AddPlaylistNavigationService>();
  final FriendsNavigatorService _friendsNavigation = locator<FriendsNavigatorService>();

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

}