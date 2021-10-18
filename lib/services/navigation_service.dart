import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

abstract class FluttifyNavigationService {
  late GlobalKey<NavigatorState> navigatorKey;
  static void _myDefaultFunc(value) {}

  /// Navigate to the provided Route with routename
  void navigateTo(
    String routeName,
    Widget view, {
    bool withNavBar = true,
    Function callback = _myDefaultFunc,
  }) {
    pushNewScreen(
      navigatorKey.currentContext!,
      screen: view,
      withNavBar: withNavBar, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    ).then((value) => {callback(value)});
  }

  /// Pop to the initial route of the Navigator
  void popAll() {
    if (navigatorKey.currentState != null) {
      if (navigatorKey.currentState!.canPop()) {
        navigatorKey.currentState!.popUntil((Route<dynamic> route) {
          return route.settings.name == '/';
        });
      }
    }
  }

  /// Pop the current widget
  void popCurrent({required bool withNavBar}) {
    if (navigatorKey.currentState != null) {
      if (navigatorKey.currentState!.canPop()) {
        Navigator.of(navigatorKey.currentContext!, rootNavigator: !withNavBar)
            .pop();
      }
    }
  }
}

class PlaylistNavigationService extends FluttifyNavigationService {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey();
}

class CommunityNavigationService extends FluttifyNavigationService {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey();
}

class DiscoverNavigationService extends FluttifyNavigationService {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey();
}

class SettingsNavigationService extends FluttifyNavigationService {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

