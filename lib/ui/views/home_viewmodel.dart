import 'package:fluttify/app/fluttify_router.gr.dart';
import 'package:fluttify/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  
  final NavigationService _navigationService = locator<NavigationService>();

  int _currentIndex = 0;
  @override
  int get currentIndex => _currentIndex;

  bool _reverse = false;

  /// Indicates whether we're going forward or backward in terms of the index we're changing.
  /// This is very helpful for the page transition directions.
  @override
  bool get reverse => _reverse;

  @override
  void setIndex(int value) {
    if (value < _currentIndex) {
      _reverse = true;
    } else {
      _reverse = false;
    }
    _currentIndex = value;
    notifyListeners();
    switch (currentIndex) {
      case 0:
        _navigationService.pushNamedAndRemoveUntil(HomeViewRoutes.playlistView, id: 1);
        break;
      case 1:
        _navigationService.pushNamedAndRemoveUntil(HomeViewRoutes.addPlaylistView, id: 1);
        break;
      case 2:
        _navigationService.pushNamedAndRemoveUntil(HomeViewRoutes.friendsView, id: 1);
        break;
      default:
        break;
    }
  }

}