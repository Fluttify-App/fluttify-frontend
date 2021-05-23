import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/app/fluttify_router.router.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class AuthService extends ChangeNotifier {
  Preference<String>? token;
  final String baseUrl = "fluttify.herokuapp.com";
  Map<String, String> headers = {"Content-Type": "application/json"};
  bool loggedIn = false;
  late User currentUser = User.empty();

  final NavigationService _navigationService = locator<NavigationService>();

  List<Object> get props => [loggedIn, headers];

  AuthService() {
    // Subscribe to shared preference changes
    StreamingSharedPreferences.instance.then((preferences) {
      token = preferences.getString("token", defaultValue: 'initial');
      token!.listen((value) async {
        print(value);
        headers.putIfAbsent('Authorization', () => 'Bearer $value');
        final response = await http.get(Uri.https(baseUrl, 'fluttify/user'),
            headers: headers);
        if (response.statusCode == 200) {
          print(response.body);
          currentUser = new User.fromJson(json.decode(response.body));
          print("Logged In");
          loggedIn = true;
          notifyListeners();
        } else {
          print("Logged In Failed");
          loggedIn = false;
          notifyListeners();
        }
      });
    });
  }

  Future<bool> initializeAuthentication() async {
    // initialize the authorization header
    var sharedPrefs = await SharedPreferences.getInstance();
    var token = sharedPrefs.getString("token");
    headers.putIfAbsent('Authorization', () => 'Bearer $token');
    return true;
  }

  void logoutBackend() async {
    token!.setValue("initial");
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
