import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/services/navigation_service.dart';
import 'package:fluttify/ui/views/playlists_views/edit_playlist_views/edit_playlist_view.dart';
import 'package:share/share.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

class DynamicLinkService {
  final PlaylistNavigationService _navigationService =
      locator<PlaylistNavigationService>();

  String? link;

  Future handleDynamicLinks() async {
    if (!kIsWeb) {
      try {
        // 1. Get the initial dynamic link if the app is opened with a dynamic link
        final PendingDynamicLinkData? data =
            await FirebaseDynamicLinks.instance.getInitialLink();

        // 2. handle link that has been retrieved
        if (data != null) {
          _handleDeepLink(data);
        }

        // 3. Register a link callback to fire if the app is opened up from the background
        // using a dynamic link.
        FirebaseDynamicLinks.instance.onLink(
            onSuccess: (PendingDynamicLinkData? dynamicLink) async {
          // 3a. handle link that has been retrieved

          _handleDeepLink(dynamicLink!);
        }, onError: (OnLinkErrorException e) async {
          print('Link Failed: ${e.message}');
        });
      } on Exception catch (e) {
        print(e);
      }
    }
  }

  void _handleDeepLink(PendingDynamicLinkData data) async {
    final Uri deepLink = data.link;
    var isPlaylist = deepLink.pathSegments.contains('playlist');
    var isAuthentication = deepLink.pathSegments.contains('fluttifyAuth');
    if (isPlaylist) {
      // get the title of the post
      var playlist = deepLink.queryParameters['id'];

      if (playlist != null) {
        print("Playlist: $playlist");

        _navigationService.navigateTo(
            '/edit-playlist', EditPlaylistView(playlistId: playlist),
            withNavBar: false);
      }
    } else if (isAuthentication) {
      // get the title of the post
      var token = deepLink.queryParameters['auth'];
      StreamingSharedPreferences sharedPrefs =
          await StreamingSharedPreferences.instance;
      sharedPrefs.setString("token", token!);
    }
  }

  Future<void> createFirstPostLink(
      BuildContext context, String playlistID) async {
    if (kIsWeb) {
      Clipboard.setData(ClipboardData(
          text:
              "https://fluttify.netpy.de/#/home-view?playlist=" + playlistID));
      final snackBar = SnackBar(
        backgroundColor: Theme.of(context).indicatorColor,
        content: Text("Link copied to clipboard"),
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 1500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://fluttify.page.link',
        link: Uri.parse('https://www.fluttify.com/playlist?id=$playlistID'),
        androidParameters: AndroidParameters(
          packageName: 'de.htwg.fluttify',
        ),
        // NOT ALL ARE REQUIRED ===== HERE AS AN EXAMPLE =====
        socialMetaTagParameters: SocialMetaTagParameters(
          title: 'Fluttify',
          description: 'Join my playlist on Fluttify!',
        ),
      );
      final Uri dynamicUrl = await parameters.buildUrl();
      Share.share(dynamicUrl.toString());
    }
  }
}
