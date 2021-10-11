import 'package:fluttify/app/fluttify_router.router.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/services/auth_service.dart';
import 'package:fluttify/ui/views/privacy_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SpotifySignInViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _apiService = locator<AuthService>();

  static const routeName = '/sign_in';

  Future<void> handleSignIn() async {
    try {
      await _apiService.authenticateBackend();
    } catch (e) {
      print(e);
    }
  }

  void navigateToHomeView() {
    _navigationService.clearStackAndShow(Routes.homeView);
  }

  void navigateToPrivacy() {
    _navigationService.navigateToView(PrivacyScreen());
  }
}
