import 'package:fluttify/app/fluttify_router.router.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/services/api_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SpotifySignInViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final ApiService _apiService = locator<ApiService>();

  bool isLoading = false;
  static const routeName = '/sign_in';

  Future<void> handleSignIn(ApiService auth) async {
    try {
      isLoading = true;
      await _apiService.authenticateBackend();
      print("Logged in");
      //Navigator.popAndPushNamed(context, HomePage.routeName);
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
