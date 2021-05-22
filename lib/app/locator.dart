import 'package:fluttify/services/api_service.dart';
import 'package:fluttify/services/fluttify_playlist_service.dart';
import 'package:fluttify/services/navigation_service.dart';
import 'package:fluttify/services/playlist_service.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => PlaylistService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => ApiService());
  // NavigationServices
  locator.registerLazySingleton(() => FluttifyPlaylistService());
  locator.registerLazySingleton(() => PlaylistNavigationService());
  locator.registerLazySingleton(() => CommunityNavigationService());
  locator.registerLazySingleton(() => SettingsNavigationService());
}
