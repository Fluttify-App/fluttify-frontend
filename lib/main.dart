import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttify/app/fluttify_router.router.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/services/auth_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:fluttify/services/dynamic_link_service.dart';
import 'package:fluttify/services/theme_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

Future main() async {
  await DotEnv.load(fileName: "assets/.env");
  setupLocator();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final preferences = await StreamingSharedPreferences.instance;

  bool? darkMode = prefs.getBool('darkMode') ?? false;
  runApp(Phoenix(
    child: MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeService(darkMode),
      )
    ], child: Fluttify(preferences)),
  ));
}

class Fluttify extends StatelessWidget {
  final AuthService _auth = locator<AuthService>();
  final DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();

  Fluttify(this.preferences);
  final StreamingSharedPreferences preferences;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _dynamicLinkService.handleDynamicLinks(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return App(preferences);
            default:
              return Container();
          }
        });
  }
}

class App extends StatelessWidget {
  final AuthService _auth = locator<AuthService>();
  App(this.preferences);
  final StreamingSharedPreferences preferences;

  @override
  Widget build(BuildContext context) {
    //_auth.logoutBackend();
    return PreferenceBuilder<String>(
        preference: preferences.getString('token', defaultValue: ""),
        builder: (BuildContext context, String token) {
          return FutureBuilder<bool>(
              future: _auth.initializeAuthentication(),
              builder:
                  (BuildContext context, AsyncSnapshot<bool> authSnapshot) {
                if (authSnapshot.connectionState == ConnectionState.done) {
                  return Consumer<ThemeService>(
                    builder: (context, notifire, child) {
                      return MaterialApp(
                        title: 'Fluttify',
                        theme: notifire.getTheme(),
                        initialRoute: token != "" && token != "initial"
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
        });
  }
}
