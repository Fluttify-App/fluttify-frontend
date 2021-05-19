import 'dart:convert';

import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:http/http.dart' as http;

import 'api_service.dart';

class FluttifyPlaylistService {
  final ApiService _apiService = locator<ApiService>();
  final String baseUrl = "fluttify.herokuapp.com";

  Future<List<Playlist>> getFluttifyPlaylists() async {
    print("getting playlists with token:");
    print(_apiService.headers.toString());
    final response = await http.get(Uri.https(baseUrl, 'fluttify/myplaylists'),
        headers: _apiService.headers);

    if (response.statusCode == 200) {
      return (json.decode(response.body)['created'] as List)
          .map((data) => Playlist.fromJson(data))
          .toList();
    } else {
      print("Not Authorized");
      return [];
    }
  }
}
