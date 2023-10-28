import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/repositories/character_repository.dart';
import '../../../../inject_dependencies.dart';
import 'state/location_state.dart';

final locationProvider =
    StateNotifierProvider<LocationController, LocationState>(
  (ref) {
    final characterRepository = ref.watch(Repositories.characterApi);
    return LocationController(characterRepository: characterRepository)..init();
  },
);

class LocationController extends StateNotifier<LocationState> {
  LocationController({required CharacterRepository characterRepository})
      : _characterRepository = characterRepository,
        super(const LocationState.loading());

  final CharacterRepository _characterRepository;

  void init({
    int page = 1,
    String name = '',
  }) async {
    state = const LocationState.loading();
    final result = await _characterRepository.locationSend(
      name: name,
      page: page,
    );

    state = result.when(
      left: (failure) => const LocationState.failed(),
      right: (value) => LocationState.loaded(value),
    );
  }
}
