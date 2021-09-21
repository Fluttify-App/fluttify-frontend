import 'package:fluttify/app/locator.dart';
import 'package:fluttify/services/fluttify_discover_service.dart';
import 'package:fluttify/services/fluttify_playlist_service.dart';
import 'package:fluttify/services/navigation_service.dart';

import 'package:stacked/stacked.dart';

class DiscoverViewModel extends BaseViewModel {
  final FluttifyDiscoverService discoverService =
      locator<FluttifyDiscoverService>();
  final FluttifyPlaylistService fluttifyPlaylistService =
      locator<FluttifyPlaylistService>();
  final DiscoverNavigationService navigationService =
      locator<DiscoverNavigationService>();
  bool isLoading = true;
  List<String> selectedGenres = [];
  List<dynamic>? playlistGenres;

  DiscoverViewModel() {
    playlistGenres = fluttifyPlaylistService.genres.toList();
  }

  void refreshDiscoverSongs() {
    isLoading = true;
    notifyListeners();
    discoverService
        .refreshDiscoverSongs(selectedGenres)
        .then((playlistsResponse) {
      isLoading = false;
      notifyListeners();
    });
  }

  void selectGenre(genre) {
    selectedGenres.add(genre);
    refreshDiscoverSongs();
  }

  void unselectGenre(genre) {
    selectedGenres.remove(genre);
    refreshDiscoverSongs();
  }
}
