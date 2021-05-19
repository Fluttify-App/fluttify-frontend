import 'package:fluttify/services/navigation_service.dart';
import 'package:fluttify/services/playlist_service.dart';
import 'package:fluttify/services/spotify_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => PlaylistService());
  // NavigationServices
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => PlaylistNavigationService());
  locator.registerLazySingleton(() => AddPlaylistNavigationService());
  locator.registerLazySingleton(() => FriendsNavigatorService());
}
