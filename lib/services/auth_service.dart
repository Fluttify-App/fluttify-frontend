import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttify/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService extends ChangeNotifier {
  Preference<String>? token;
  final String baseUrl = "fluttify.herokuapp.com";
  Map<String, String> headers = {"Content-Type": "application/json"};
  late User currentUser = User.empty();

  List<Object> get props => [headers];

  Future<bool> initializeAuthentication() async {
    // initialize the authorization header
    var sharedPrefs = await SharedPreferences.getInstance();
    var token = sharedPrefs.getString("token");
    if (token == null || token != "initial") {
      headers.update('Authorization', (oldToken) => 'Bearer $token',
          ifAbsent: () => 'Bearer $token');
      var loggedIn = await _getUser();
      if (loggedIn) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Future<bool> setWebAuthentication(String webToken) async {
    var sharedPrefs = await SharedPreferences.getInstance();
    headers.update('Authorization', (oldToken) => 'Bearer $webToken',
        ifAbsent: () => 'Bearer $webToken');
    sharedPrefs.setString("token", webToken);
    var loggedIn = await _getUser();
    if (loggedIn) {
      return true;
    } else {
      return false;
    }
  }

  void logoutBackend() async {
    final preferences = await StreamingSharedPreferences.instance;
    await preferences.setString('token', "initial");
  }

  Future<void> authenticateBackend() async {
    Response response;
    if (kIsWeb) {
      response =
          await http.get(Uri.https(baseUrl, 'auth/login', {"web": "true"}));
    } else {
      response = await http.get(Uri.https(baseUrl, 'auth/login'));
    }
    final url = response.body;
    try {
      await launch(
        url.toString(),
        forceSafariVC: true,
        forceWebView: true,
        webOnlyWindowName: '_self',
      );
    } catch (e) {
      print(e);
    }
  }

  Future<bool> _getUser() async {
    final response =
        await http.get(Uri.https(baseUrl, 'fluttify/user'), headers: headers);
    if (response.statusCode == 200) {
      currentUser = new User.fromJson(json.decode(response.body));
      return true;
    } else {
      print("Logged In Failed");
      return false;
    }
  }
}
