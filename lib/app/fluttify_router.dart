import 'package:fluttify/ui/views/home_view.dart';
import 'package:fluttify/ui/views/splashscreen_views/splashscreen_view.dart';
import 'package:fluttify/ui/views/spotify_sign_in/spotify_sign_in_view.dart';
import 'package:stacked/stacked_annotations.dart';

// flutter packages pub run build_runner build

@StackedApp(
  routes: <StackedRoute<dynamic>>[
    MaterialRoute<dynamic>(page: SplashScreenView),
    MaterialRoute<dynamic>(page: SpotifySignInView),
    MaterialRoute<dynamic>(page: HomeView)
  ],
)
class $FluttifyRouter {}
