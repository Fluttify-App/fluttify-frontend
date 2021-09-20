import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttify/app/fluttify_router.router.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/l10n/l10n.dart';
import 'package:fluttify/services/auth_service.dart';
import 'package:fluttify/services/dynamic_link_service.dart';
import 'package:fluttify/services/locale_service.dart';
import 'package:fluttify/services/theme_service.dart';
import 'package:fluttify/ui/views/splashscreen_views/splashscreen_view.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final preferences = await StreamingSharedPreferences.instance;

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  bool? darkMode = prefs.getBool('darkMode') ?? false;
  int? color = prefs.getInt('theme') ?? 0xffCB2D3E;
  List<String?> language = <String?>[prefs.getString('locale')];

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(color),
  ));

  runApp(Phoenix(
    child: MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeService(darkMode, color: Color(color)),
      ),
      ChangeNotifierProvider(
          create: (context) => LocaleService(language[0] == null
              ? !kIsWeb
                  ? (!(Platform.localeName.split('_')[0] == 'en' ||
                          Platform.localeName.split('_')[0] == 'de')
                      ? Locale('en')
                      : Locale(Platform.localeName.split('_')[0]))
                  : Locale('en')
              : Locale(language[0]!)))
    ], child: Fluttify(preferences)),
  ));
}

class Fluttify extends StatelessWidget {
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
    var localeService = Provider.of<LocaleService>(context);
    Preference<bool> isOnboarded =
        preferences.getBool('isOnboarded', defaultValue: false);
    var url = html.window.location.href;
    bool redirectedFromWebAuth = url.contains('auth');
    bool redirectedFromWebPlaylist = url.contains('playlist');
    if (redirectedFromWebPlaylist) {
      preferences.setString('playlist', url.substring(url.indexOf('?') + 10));
    }
    return PreferenceBuilder<String>(
      preference: preferences.getString('token', defaultValue: ""),
      builder: (BuildContext context, String token) {
        return FutureBuilder<bool>(
          future: !redirectedFromWebAuth
              ? _auth.initializeAuthentication()
              : _auth.setWebAuthentication(url
                  .substring(url.indexOf('?') + 6)), // cut token after '?auth='
          builder: (BuildContext context, AsyncSnapshot<bool> authSnapshot) {
            if (authSnapshot.connectionState == ConnectionState.done) {
              return Consumer<ThemeService>(
                builder: (context, notifire, child) {
                  return MaterialApp(
                    locale: localeService.locale,
                    supportedLocales: L10n.all,
                    localizationsDelegates: [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate
                    ],
                    title: 'Fluttify',
                    theme: notifire.getTheme(),
                    initialRoute: (token != "" && token != "initial") ||
                            (redirectedFromWebAuth == true)
                        ? isOnboarded.getValue()
                            ? Routes.homeView
                            : Routes.onboardingView
                        : Routes.spotifySignInView,
                    navigatorKey: StackedService.navigatorKey,
                    onGenerateRoute: StackedRouter().onGenerateRoute,
                  );
                },
              );
            } else {
              return Consumer<ThemeService>(
                  builder: (context, notifire, child) {
                return MaterialApp(
                  supportedLocales: L10n.all,
                  theme: notifire.getTheme(),
                  home: SplashScreenView(),
                );
              });
            }
          },
        );
      },
    );
  }
}
