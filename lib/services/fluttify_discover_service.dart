import 'dart:convert';

import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/models/song.dart';
import 'package:http/http.dart' as http;

import 'auth_service.dart';

class FluttifyDiscoverService {
  final AuthService _apiService = locator<AuthService>();
  final String baseUrl = "fluttify.netpy.de";

  List<Song> discoverSongs = [];

  Future<void> refreshDiscoverSongs(genre) async {
    var query = {"genres": genre.join(',').toString()};
    final response = await http.get(
        Uri.https(baseUrl, 'fluttify/discover', query),
        headers: _apiService.headers);
    if (response.statusCode == 200) {
      List songs = (json.decode(response.body) as List);
      discoverSongs = songs.map((data) => Song.fromJson(data)).toList();
    } else {
      discoverSongs = [];
    }
  }
}
