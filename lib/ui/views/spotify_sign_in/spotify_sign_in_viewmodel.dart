import 'package:fluttify/app/fluttify_router.router.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SpotifySignInViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _apiService = locator<AuthService>();

  bool isLoading = false;
  static const routeName = '/sign_in';

  Future<void> handleSignIn() async {
    try {
      isLoading = true;
      await _apiService.authenticateBackend();
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
    }
  }

  void navigateToHomeView() {
    _navigationService.clearStackAndShow(Routes.homeView);
  }
}
