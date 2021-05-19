

import 'package:fluttify/app/fluttify_router.router.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/services/spotify_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignInViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  bool isLoading = false;
  static const routeName = '/sign_in';

  Future<void> handleSignIn(SpotifyAuth auth) async {
    try {
      isLoading = true;
      await auth.authenticate();
      print("Logged in");
      navigateToHomeView();
      //Navigator.popAndPushNamed(context, HomePage.routeName);
    } catch (e) {
      //CustomToast.showTextToast(
      //   text: "Failed to sign in", toastType: ToastType.error);
    } finally {
      isLoading = false;
    }
  }
  /*
  Future<void> _initialSignIn() async {
    final auth = context.read<SpotifyAuth>();
    final uriManager = SpotifyUriManager(auth);
    setState(() => _isLoading = true);
    try {
      final initialUri = await getInitialUri();
      if (initialUri == null) {
        _signInFromSavedTokens();
        return;
      }
      await uriManager.handleLoadFromUri(initialUri);
    } catch (e) {
      if (!mounted) return;
      uriManager.handleFail();
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signInFromSavedTokens() async {
    final auth = context.read<SpotifyAuth>();
    setState(() => _isLoading = true);
    try {
      await auth.signInFromSavedTokens();
      Navigator.popAndPushNamed(context, HomePage.routeName);
    } catch (_) {} finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleSignIn(SpotifyAuth auth, BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      await auth.authenticate();
      Navigator.popAndPushNamed(context, HomePage.routeName);
    } catch (e) {
      CustomToast.showTextToast(
          text: "Failed to sign in", toastType: ToastType.error);
    } finally {
      setState(() => _isLoading = false);
    }
  }
*/
  void navigateToHomeView() {
    _navigationService.clearStackAndShow(Routes.homeView);
  }
}