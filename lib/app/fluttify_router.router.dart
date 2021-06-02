// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:fluttify/ui/views/splashscreen_views/splashscreen_view.dart';
import 'package:fluttify/ui/views/spotify_sign_in/spotify_sign_in_view.dart';
import 'package:stacked/stacked.dart';

import '../ui/views/home_view.dart';

class Routes {
  static const String spotifySignInView = '/';
  static const String homeView = '/home-view';
  static const String splashScreenView = '/splash-view';
  static const all = <String>{
    splashScreenView,
    spotifySignInView,
    homeView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashScreenView, page: SplashScreenView),
    RouteDef(Routes.spotifySignInView, page: SpotifySignInView),
    RouteDef(Routes.homeView, page: HomeView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    SplashScreenView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashScreenView(),
        settings: data,
      );
    },
    SpotifySignInView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SpotifySignInView(),
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
