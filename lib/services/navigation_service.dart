import 'package:flutter/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

abstract class FluttifyNavigationService {
  
  GlobalKey<NavigatorState> navigatorKey;

  /// Navigate to the provided Route with routename
  void navigateTo(String routeName, Widget view, {bool withNavBar = true}) {
    pushNewScreen(
      navigatorKey.currentContext,
      screen: view,
      withNavBar: withNavBar, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.slideUp,
    );
  }

  /// Pop to the initial route of the Navigator
  void popAll() {
    if (navigatorKey.currentState != null) {
      if (navigatorKey.currentState.canPop()) {
        navigatorKey.currentState.popUntil((Route<dynamic> route) {
          return route.settings.name == '/';
        });
      }
    }
  }

  /// Pop the current widget
  void popCurrent({bool withNavBar}) {
    if (navigatorKey.currentState != null) {
      if (navigatorKey.currentState.canPop()) {
        Navigator.of(navigatorKey.currentContext, rootNavigator: !withNavBar)
            .pop();
      }
    }
  }
}

class PlaylistNavigationService extends FluttifyNavigationService {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class AddPlaylistNavigationService extends FluttifyNavigationService {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class FriendsNavigatorService extends FluttifyNavigationService {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}