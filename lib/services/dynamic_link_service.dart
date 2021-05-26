import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:fluttify/app/fluttify_router.router.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/services/navigation_service.dart';
import 'package:fluttify/ui/views/home_view.dart';
import 'package:fluttify/ui/views/playlists_views/edit_playlist_views/edit_playlist_view.dart';
import 'package:share/share.dart';
import 'package:stacked_services/stacked_services.dart';

class DynamicLinkService {
  final PlaylistNavigationService _navigationService =
      locator<PlaylistNavigationService>();
  Future handleDynamicLinks() async {
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

  void _handleDeepLink(PendingDynamicLinkData data) {
    final Uri deepLink = data.link;
    if (deepLink != null) {
      print('_handleDeepLink | deeplink: $deepLink');

      // Check if we want to make a post
      var isPlaylist = deepLink.pathSegments.contains('playlist');

      if (isPlaylist) {
        // get the title of the post
        var playlist = deepLink.queryParameters['id'];

        if (playlist != null) {
          print("Playlist: $playlist");
          // if we have a post navigate to the CreatePostViewRoute and pass in the title as the arguments.
          //_navigationService.navigateTo(CreatePostViewRoute, arguments: title);

          _navigationService.navigateTo(
              '/edit-playlist', EditPlaylistView(playlistId: playlist));

          //_navigationService.clearStackAndShow(Routes.homeView);
        }
      }
    }
  }

  Future<void> createFirstPostLink(String playlistID) async {
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
