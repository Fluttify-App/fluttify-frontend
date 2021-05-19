import 'dart:convert';

import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:http/http.dart';
import 'package:lipsum/lipsum.dart' as lipsum;
import 'package:http/http.dart' as http;

import 'api_service.dart';

class FluttifyPlaylistService {
  final ApiService _apiService = locator<ApiService>();
  final String baseUrl = "fluttify.herokuapp.com";

  Future<List<Playlist>> getFluttifyPlaylists() async {
    final response = await http.get(Uri.https(baseUrl, 'fluttify/myplaylists'),
        headers: _apiService.headers);
    return (json.decode(response.body)['created'] as List)
        .map((data) => Playlist.fromJson(data))
        .toList();
  }
}
