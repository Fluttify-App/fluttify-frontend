import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/services/mock_data_playlist.dart';
import 'package:fluttify/ui/views/playlists_views/playlist_view.dart';
import 'package:stacked/stacked.dart';

class PlaylistViewModel extends BaseViewModel {

  final MockDataPlaylistService mockdata = locator<MockDataPlaylistService>();

  List<Playlist> playlists = <Playlist>[];

  PlaylistViewModel() {
    playlists = mockdata.getPlaylists();
  }
  
}