import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttify/app/fluttify_router.router.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/l10n/l10n.dart';
import 'package:fluttify/services/auth_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:fluttify/services/dynamic_link_service.dart';
import 'package:fluttify/services/locale_service.dart';
import 'package:fluttify/services/theme_service.dart';
import 'package:fluttify/ui/styles/colors.dart';
import 'package:fluttify/ui/views/splashscreen_views/splashscreen_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future main() async {
  await DotEnv.load(fileName: "assets/.env");
  setupLocator();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final preferences = await StreamingSharedPreferences.instance;

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  bool? darkMode = prefs.getBool('darkMode') ?? false;
  String? language = prefs.getString('locale') ?? 'en';
  runApp(Phoenix(
    child: MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeService(darkMode),
      ),
      ChangeNotifierProvider(
          create: (context) => LocaleService(Locale(language)))
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
    bool isOnboarded = false;
    return PreferenceBuilder<String>(
      preference: preferences.getString('token', defaultValue: ""),
      builder: (BuildContext context, String token) {
        return FutureBuilder<bool>(
          future: _auth.initializeAuthentication(),
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
                    initialRoute: token != "" && token != "initial"
                        ? isOnboarded
                            ? Routes.homeView
                            : Routes.onboardingView
                        : Routes.spotifySignInView,
                    navigatorKey: StackedService.navigatorKey,
                    onGenerateRoute: StackedRouter().onGenerateRoute,
                  );
                },
              );
            } else {
              return MaterialApp(
                supportedLocales: L10n.all,
                home: SplashScreenView(),
              );
            }
          },
        );
      },
    );
  }
}
