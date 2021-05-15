import 'package:fluttify/app/fluttify_router.gr.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/services/api_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SpotifySignInViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  bool isLoading = false;
  static const routeName = '/sign_in';

  Future<void> loginWithSpotify(ApiService auth) async {
    try {
      isLoading = true;
      await auth.authenticateBackend();
    } catch (e) {} finally {
      isLoading = false;
    }
  }

  void navigateToHomeView() {
    _navigationService.clearStackAndShow(Routes.homeView);
  }
}
