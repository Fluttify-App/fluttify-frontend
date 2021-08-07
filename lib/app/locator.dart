import 'package:fluttify/services/auth_service.dart';
import 'package:fluttify/services/dynamic_link_service.dart';
import 'package:fluttify/services/fluttify_discover_service.dart';
import 'package:fluttify/services/fluttify_playlist_service.dart';
import 'package:fluttify/services/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => DynamicLinkService());

  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => FluttifyPlaylistService());
  locator.registerLazySingleton(() => FluttifyDiscoverService());
  // NavigationServices
  locator.registerLazySingleton(() => PlaylistNavigationService());
  locator.registerLazySingleton(() => CommunityNavigationService());
  locator.registerLazySingleton(() => DiscoverNavigationService());
  locator.registerLazySingleton(() => SettingsNavigationService());
}
