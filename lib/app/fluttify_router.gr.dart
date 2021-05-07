// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/views/add_playlist_views/add_playlist_view.dart';
import '../ui/views/friends_views/friends_view.dart';
import '../ui/views/home_view.dart';
import '../ui/views/playlists_views/playlist_view.dart';
import '../ui/views/sign_in_views/sign_in_view.dart';

class Routes {
  static const String signInView = '/';
  static const String homeView = '/home-view';
  static const all = <String>{
    signInView,
    homeView,
  };
}

class FluttifyRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.signInView, page: SignInView),
    RouteDef(
      Routes.homeView,
      page: HomeView,
      generator: HomeViewRouter(),
    ),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SignInView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignInView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
  };
}

class HomeViewRoutes {
  static const String playlistView = '/';
  static const String addPlaylistView = '/add-playlist-view';
  static const String friendsView = '/friends-view';
  static const all = <String>{
    playlistView,
    addPlaylistView,
    friendsView,
  };
}

class HomeViewRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(HomeViewRoutes.playlistView, page: PlaylistView),
    RouteDef(HomeViewRoutes.addPlaylistView, page: AddPlaylistView),
    RouteDef(HomeViewRoutes.friendsView, page: FriendsView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    PlaylistView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => PlaylistView(),
        settings: data,
      );
    },
    AddPlaylistView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddPlaylistView(),
        settings: data,
      );
    },
    FriendsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => FriendsView(),
        settings: data,
      );
    },
  };
}
