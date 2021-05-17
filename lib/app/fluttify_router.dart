import 'package:auto_route/auto_route_annotations.dart';
import 'package:fluttify/ui/views/add_playlist_views/add_playlist_view.dart';
import 'package:fluttify/ui/views/friends_views/friends_view.dart';
import 'package:fluttify/ui/views/home_view.dart';
import 'package:fluttify/ui/views/playlists_views/playlist_view.dart';
import 'package:fluttify/ui/views/spotify_sign_in/spotify_sign_in_view.dart';

// gr Datei wird automatisch neu gebuilded, falls nicht
// 'flutter packages pub run build_runner build' ausführen
// Fehler treten in der gr Datei bei den homeviewroutes auf, kein Plan wieso,
// einfach bei dem string nach dem '/' was hinschreiben (anscheinend egal was)
@MaterialAutoRouter(routes: <AutoRoute<dynamic>>[
  MaterialRoute(page: SpotifySignInView, initial: true),
  MaterialRoute(page: HomeView, children: [
    MaterialRoute(page: PlaylistView, initial: true),
    MaterialRoute(page: AddPlaylistView),
    MaterialRoute(page: FriendsView)
  ])
])
class $FluttifyRouter {}
