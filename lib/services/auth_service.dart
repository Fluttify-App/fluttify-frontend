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
  late User currentUser = User.empty();

  final NavigationService _navigationService = locator<NavigationService>();

  List<Object> get props => [headers];

  AuthService() {}

  Future<bool> initializeAuthentication() async {
    // initialize the authorization header
    var sharedPrefs = await SharedPreferences.getInstance();
    var token = sharedPrefs.getString("token");
    print(token);
    if (token == null || token != "initial") {
      headers.putIfAbsent('Authorization', () => 'Bearer $token');
      var loggedIn = await _getUser();
      if (loggedIn) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  void logoutBackend() async {
    final preferences = await StreamingSharedPreferences.instance;
    preferences.setString('token', "initial");
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

  Future<bool> _getUser() async {
    final response =
        await http.get(Uri.https(baseUrl, 'fluttify/user'), headers: headers);
    if (response.statusCode == 200) {
      currentUser = new User.fromJson(json.decode(response.body));
      print("Logged In");
      return true;
    } else {
      print("Logged In Failed");
      return false;
    }
  }
}
