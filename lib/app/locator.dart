import 'package:fluttify/services/api_service.dart';
import 'package:fluttify/services/fluttify_playlist_service.dart';
import 'package:fluttify/services/mock_data_playlist.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => MockDataPlaylistService());
  locator.registerLazySingleton(() => FluttifyPlaylistService());
}
