import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:fluttify/models/user.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class SpotifyAuth extends ChangeNotifier {
  User user;

  /*
  Future<void> authenticate() async {
    final clientId = DotEnv().env['CLIENT_ID'];
    final redirectUri = DotEnv().env['REDIRECT_URI'];
    final state = _getRandomString(6);

    try {
      final result = await FlutterWebAuth.authenticate(
        url: APIPath.requestAuthorization(clientId, redirectUri, state),
        callbackUrlScheme: DotEnv().env['CALLBACK_URL_SCHEME'],
      );

      // Validate state from response
      final returnedState = Uri.parse(result).queryParameters['state'];
      if (state != returnedState) throw HttpException('Invalid access');

      final code = Uri.parse(result).queryParameters['code'];
      final tokens = await SpotifyAuthApi.getAuthTokens(code, redirectUri);
      await tokens.saveToStorage();

      user = await SpotifyApi.getCurrentUser(); // Uses token in storage
      notifyListeners();
    } on Exception catch (e) {
      print(e);
      rethrow;
    }
  }

  /// If there is a saved token, update the token and sign in
  Future<void> signInFromSavedTokens() async {
    try {
      await AuthTokens.updateTokenToLatest();

      user = await SpotifyApi.getCurrentUser(); // Uses token in storage
      notifyListeners();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static String _getRandomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }
  */

  Future<void> authenticate() async {
    try {
      print("Try to get auth");
      var authenticationToken = await SpotifySdk.getAuthenticationToken(
          clientId: DotEnv.env['CLIENT_ID'].toString(),
          redirectUrl: DotEnv.env['REDIRECT_URL'].toString(),
          scope: 'app-remote-control, '
              'user-modify-playback-state, '
              'playlist-read-private, '
              'playlist-modify-public,user-read-currently-playing');
      //setStatus('Got a token: $authenticationToken');
      print(authenticationToken);
      return authenticationToken;
    } on PlatformException catch (e) {
      return Future.error('$e.code: $e.message');
    } on MissingPluginException {
      return Future.error('not implemented');
    }
  }
}
