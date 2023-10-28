import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/repositories/character_repository.dart';
import '../../../../inject_dependencies.dart';
import 'state/episodes_state.dart';

final episodesProvider =
    StateNotifierProvider<EpisodesController, EpisodesState>(
  (ref) {
    final characterRepository = ref.watch(Repositories.characterApi);
    return EpisodesController(characterRepository: characterRepository)..init();
  },
);

class EpisodesController extends StateNotifier<EpisodesState> {
  EpisodesController({required CharacterRepository characterRepository})
      : _characterRepository = characterRepository,
        super(const EpisodesState.loading());

  final CharacterRepository _characterRepository;

  void init({
    int page = 1,
    String name = '',
  }) async {
    state = const EpisodesState.loading();
    final result = await _characterRepository.episodesSend(
      name: name,
      page: page,
    );

    state = result.when(
      left: (failure) => const EpisodesState.failed(),
      right: (value) => EpisodesState.loaded(value),
    );
  }
}
