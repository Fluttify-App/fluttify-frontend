import 'dart:convert';

import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:http/http.dart' as http;

import 'auth_service.dart';

class FluttifyPlaylistService {
  final AuthService _apiService = locator<AuthService>();
  final String baseUrl = "fluttify.herokuapp.com";

  List<Playlist> myplaylists = [];

  Future<void> refreshFluttifyPlaylists() async {
    final response = await http.get(Uri.https(baseUrl, 'fluttify/myplaylists'),
        headers: _apiService.headers);

    if (response.statusCode == 200) {
      myplaylists = (json.decode(response.body)['created'] as List)
          .map((data) => Playlist.fromJson(data))
          .toList();
    } else {
      myplaylists = [];
    }
  }

  Future<bool> saveFluttifyPlaylist(Playlist playlist) async {
    var payload = {};
    payload['mix'] = playlist;
    final response = await http.post(Uri.https(baseUrl, 'fluttify/playlist'),
        headers: _apiService.headers, body: jsonEncode(payload));
    if (response.statusCode == 200) {
      return true;
    } else {
      print("Something went wrong");
      return false;
    }
  }

  Future<bool> removeFluttifyPlaylist(Playlist playlist) async {
    var payload = {};
    payload['id'] = playlist.dbID;
    final response = await http.delete(Uri.https(baseUrl, 'fluttify/playlist'),
        headers: _apiService.headers, body: jsonEncode(payload));
    if (response.statusCode == 200) {
      return true;
    } else {
      print("Something went wrong");
      return false;
    }
  }
}
