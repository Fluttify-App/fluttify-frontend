
import 'package:auto_route/auto_route_annotations.dart';
import 'package:fluttify/ui/views/add_playlist_views/add_playlist_view.dart';
import 'package:fluttify/ui/views/friends_views/friends_view.dart';
import 'package:fluttify/ui/views/home_view.dart';
import 'package:fluttify/ui/views/playlists_views/playlist_view.dart';
import 'package:fluttify/ui/views/sign_in_views/sign_in_view.dart';

@MaterialAutoRouter(
  routes: <AutoRoute<dynamic>>[
    MaterialRoute(page: SignInView, initial: true),
    MaterialRoute(page: HomeView, children: [
      MaterialRoute(page: PlaylistView, initial: true),
      MaterialRoute(page: AddPlaylistView, initial: true),
      MaterialRoute(page: FriendsView, initial: true)
    ])
  ]
)
class $FluttifyRouter {}