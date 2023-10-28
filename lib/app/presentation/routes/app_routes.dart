import 'package:flutter/widgets.dart' show BuildContext, Widget;

import '../modules/character/view/character_view.dart';
import '../modules/episode/view/episode_view.dart';
import '../modules/home/view/home_view.dart';
import '../modules/location/view/location_view.dart';
import '../modules/offline/view/offline_view.dart';
import '../modules/splash/view/splash_view.dart';
import 'routes.dart';

/// WARNING: generated code don't modify directly
Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.HOME: (_) => const HomeView(),
    Routes.SPLASH: (_) => const SplashView(),
    Routes.OFFLINE: (_) => const OfflineView(),
    Routes.CHARACTER: (_) => const CharacterView(),
    Routes.LOCATION: (_) => const LocationView(),
    Routes.EPISODE: (_) => const EpisodeView(),
  };
}
