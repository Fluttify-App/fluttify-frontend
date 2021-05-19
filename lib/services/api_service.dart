import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/app/fluttify_router.gr.dart';
import 'package:fluttify/app/locator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class ApiService extends ChangeNotifier {
  Preference<String> token;
  final String baseUrl = "fluttify.herokuapp.com";
  Map<String, String> headers = {};
  bool loggedIn = false;

  final NavigationService _navigationService = locator<NavigationService>();

  List<Object> get props => [loggedIn, headers];

  ApiService() {
    StreamingSharedPreferences.instance.then((preferences) {
      token = preferences.getString("token", defaultValue: 'initial');
      token.listen((value) async {
        print(value);
        headers = {'Authorization': 'Bearer $value'};
        final response = await http.get(Uri.https(baseUrl, 'fluttify/user'),
            headers: headers);
        if (response.statusCode == 200) {
          print("Logged In");
          loggedIn = true;
          notifyListeners();
        }
      });
    });
  }

  void logoutBackend() async {
    token.setValue("initial");
    loggedIn = false;
    _navigationService.clearStackAndShow(Routes.spotifySignInView);
  }

  Future<void> authenticateBackend() async {
    final response = await http.get(Uri.https(baseUrl, 'auth/login'));
    final url = response.body;
    try {
      await launch(url.toString());
    } catch (e) {
      print(e);
    }
  }

  Future<void> getUser() async {
    final response =
        await http.get(Uri.https(baseUrl, 'fluttify/user'), headers: headers);
    print(response.statusCode);
    print(response.body);
  }
}
