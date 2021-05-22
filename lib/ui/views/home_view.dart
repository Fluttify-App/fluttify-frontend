import 'package:flutter/material.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/services/navigation_service.dart';
import 'package:fluttify/ui/styles/colors.dart';
import 'package:fluttify/ui/views/community_views/community_view.dart';
import 'package:fluttify/ui/views/home_viewmodel.dart';
import 'package:fluttify/ui/views/playlists_views/add_playlist_views/add_playlist_view.dart';
import 'package:fluttify/ui/views/playlists_views/playlist_view/playlist_view.dart';
import 'package:fluttify/ui/views/settings_views/settings_view.dart';
import 'package:stacked/stacked.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeView extends StatelessWidget {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (BuildContext context, HomeViewModel model, Widget? child) =>
          PersistentTabView(
        context,
        onItemSelected: model.resetOnItemchange,
        screens: _buildScreens(),
        items: _buildNavBarItems(),
        decoration: NavBarDecoration(
          gradient: LinearGradient(
              colors: <Color>[fluttify_gradient_1, fluttify_gradient_1],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        confineInSafeArea: true,
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: false, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.once,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style6, // Choose the nav bar style with this property.
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }

  List<Widget> _buildScreens() {
    return <Widget>[
      PlaylistView(),
      CommunityView(),
      SettingsView(),
    ];
  }

  // TODO: Icons anpassen
  List<PersistentBottomNavBarItem> _buildNavBarItems() {
    return <PersistentBottomNavBarItem>[
      PersistentBottomNavBarItem(
        title: 'Playlists',
        icon: Icon(Icons.playlist_add),
        activeColorPrimary: Colors.white,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          navigatorKey: locator<PlaylistNavigationService>().navigatorKey,
          initialRoute: '/',
        ),
      ),
      PersistentBottomNavBarItem(
        title: 'Community',
        icon: Icon(Icons.people),
        activeColorPrimary: Colors.white,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          navigatorKey: locator<CommunityNavigationService>().navigatorKey,
          initialRoute: '/',
        ),
      ),
      PersistentBottomNavBarItem(
        title: 'Settings',
        icon: Icon(Icons.settings),
        activeColorPrimary: Colors.white,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          navigatorKey: locator<SettingsNavigationService>().navigatorKey,
          initialRoute: '/',
        ),
      ),
    ];
  }
}
