import 'package:fluttify/app/locator.dart';
import 'package:fluttify/services/auth_service.dart';
import 'package:fluttify/services/theme_service.dart';
import 'package:stacked/stacked.dart';

class UserViewModel extends BaseViewModel {
  final AuthService authService = locator<AuthService>();
}
