import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/services/navigation_service.dart';
import 'package:fluttify/ui/views/community_views/community_view/community_view.dart';
import 'package:fluttify/ui/views/home_viewmodel.dart';
import 'package:fluttify/ui/views/playlists_views/playlist_view/playlist_view.dart';
import 'package:stacked/stacked.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:web_browser_detect/web_browser_detect.dart';

import 'discover_views/discover_view.dart';

class HomeView extends StatelessWidget {
  var browser = Browser.detectOrNull();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (BuildContext context, HomeViewModel model, Widget? child) =>
          FutureBuilder<void>(
              future: model.routeInWeb(context),
              builder:
                  (BuildContext context, AsyncSnapshot<void> authSnapshot) {
                return GestureDetector(
                  onHorizontalDragEnd: model.detectSwipe,
                  child: Container(
                    padding: browser!.browserAgent == BrowserAgent.Safari
                        ? const EdgeInsets.only(bottom: 24)
                        : null,
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .backgroundColor!,
                    child: PersistentTabView(
                      context,
                      controller: model.controller,
                      onItemSelected: model.resetOnItemchange,
                      screens: _buildScreens(),
                      items: _buildNavBarItems(context),
                      backgroundColor: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor!,
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
                      navBarStyle: NavBarStyle
                          .style6, // Choose the nav bar style with this property.
                    ),
                  ),
                );
              }),
      viewModelBuilder: () => HomeViewModel(),
    );
  }

  List<Widget> _buildScreens() {
    return <Widget>[
      PlaylistView(),
      CommunityView(),
      DiscoverView(),
    ];
  }

  List<PersistentBottomNavBarItem> _buildNavBarItems(BuildContext context) {
    return <PersistentBottomNavBarItem>[
      PersistentBottomNavBarItem(
        title: AppLocalizations.of(context)!.playlists,
        icon: Icon(Icons.home),
        activeColorPrimary: Theme.of(context).colorScheme.secondary,
        inactiveColorPrimary: HSLColor.fromColor(Theme.of(context).colorScheme.secondary)
            .withAlpha(0.5)
            .toColor(),
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          navigatorKey: locator<PlaylistNavigationService>().navigatorKey,
          initialRoute: '/',
        ),
      ),
      PersistentBottomNavBarItem(
        title: AppLocalizations.of(context)!.community,
        icon: Icon(Icons.people),
        activeColorPrimary: Theme.of(context).colorScheme.secondary,
        inactiveColorPrimary: HSLColor.fromColor(Theme.of(context).colorScheme.secondary)
            .withAlpha(0.5)
            .toColor(),
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          navigatorKey: locator<CommunityNavigationService>().navigatorKey,
          initialRoute: '/',
        ),
      ),
      PersistentBottomNavBarItem(
        title: AppLocalizations.of(context)!.discover,
        icon: Icon(Icons.explore),
        activeColorPrimary: Theme.of(context).colorScheme.secondary,
        inactiveColorPrimary: HSLColor.fromColor(Theme.of(context).colorScheme.secondary)
            .withAlpha(0.5)
            .toColor(),
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          navigatorKey: locator<DiscoverNavigationService>().navigatorKey,
          initialRoute: '/',
        ),
      ),
    ];
  }
}
