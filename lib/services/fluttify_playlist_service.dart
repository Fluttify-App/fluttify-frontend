import 'dart:convert';

import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:http/http.dart' as http;

import 'auth_service.dart';

class FluttifyPlaylistService {
  final AuthService _apiService = locator<AuthService>();
  final String baseUrl = "fluttify.herokuapp.com";

  List<Playlist> myplaylists = [];
  List<dynamic> genres = [];

  FluttifyPlaylistService() {
    // get genres
    http
        .get(Uri.https(baseUrl, 'fluttify/genres'),
            headers: _apiService.headers)
        .then((response) {
      genres = json.decode(response.body);
    });
  }

  Future<void> refreshFluttifyPlaylists() async {
    final response = await http.get(Uri.https(baseUrl, 'fluttify/myplaylists'),
        headers: _apiService.headers);

    if (response.statusCode == 200) {
      var createdPlaylists = (json.decode(response.body)['created'] as List);
      var subscribedPlaylists =
          (json.decode(response.body)['subscribed'] as List);
      var showPlaylists = createdPlaylists + subscribedPlaylists;
      myplaylists =
          showPlaylists.map((data) => Playlist.fromJson(data)).toList();
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

  Future<Playlist> getFluttifyPlaylist(String playlistId) async {
    var query = {"id": playlistId};
    final response = await http.get(
        Uri.https(baseUrl, 'fluttify/playlist', query),
        headers: _apiService.headers);
    if (response.statusCode == 200) {
      try {
        var playlist = Playlist.fromJson(json.decode(response.body));
        return playlist;
      } on Exception catch (e) {
        print(e);
        return Playlist();
      }
    } else {
      print("Something went wrong");
      return Playlist();
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

  Future<Playlist> joinFluttifyPlaylist(Playlist playlist) async {
    var payload = {};
    payload['id'] = playlist.dbID;
    final response = await http.put(Uri.https(baseUrl, 'fluttify/playlist'),
        headers: _apiService.headers, body: jsonEncode(payload));
    if (response.statusCode == 200) {
      return Playlist.fromJson(json.decode(response.body));
    } else {
      print("Something went wrong");
      throw Exception();
    }
  }

  Future<Playlist> updateFluttifyPlaylist(Playlist playlist) async {
    var payload = {};
    payload['id'] = playlist.dbID;
    final response = await http.post(Uri.https(baseUrl, 'fluttify/playlistjob'),
        headers: _apiService.headers, body: jsonEncode(payload));
    if (response.statusCode == 200) {
      return Playlist.fromJson(json.decode(response.body));
    } else {
      print("Something went wrong");
      throw Exception();
    }
  }
}
