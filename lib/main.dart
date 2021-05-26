import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttify/app/fluttify_router.router.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/services/auth_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:fluttify/services/dynamic_link_service.dart';
import 'package:fluttify/services/theme_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

Future main() async {
  await DotEnv.load(fileName: "assets/.env");
  setupLocator();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? darkMode = prefs.getBool('darkMode') ?? false;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ThemeService(darkMode),
    )
  ], child: Fluttify()));
}

class Fluttify extends StatelessWidget {
  final AuthService _auth = locator<AuthService>();
  final DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _dynamicLinkService.handleDynamicLinks(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return App();
            default:
              return Container();
          }
        });
  }
}

class App extends StatelessWidget {
  final AuthService _auth = locator<AuthService>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: _auth.initializeAuthentication(),
        builder: (BuildContext context, AsyncSnapshot<bool> authSnapshot) {
          if (authSnapshot.connectionState == ConnectionState.done) {
            return Consumer<ThemeService>(
              builder: (context, notifire, child) {
                return MaterialApp(
                  title: 'Fluttify',
                  theme: notifire.getTheme(),
                  initialRoute: authSnapshot.data == true
                      ? Routes.homeView
                      : Routes.spotifySignInView,
                  navigatorKey: StackedService.navigatorKey,
                  onGenerateRoute: StackedRouter().onGenerateRoute,
                );
              },
            );
          } else {
            return Container();
          }
        });
  }
}
