import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/repositories/character_repository.dart';
import '../../../../inject_dependencies.dart';
import 'state/character_state.dart';

final characterController =
    StateNotifierProvider<CharacterController, CharacterState>(
  (ref) {
    final characterRepository = ref.watch(Repositories.characterApi);
    return CharacterController(characterRepository: characterRepository)
      ..init();
  },
);

class CharacterController extends StateNotifier<CharacterState> {
  CharacterController({required CharacterRepository characterRepository})
      : _characterRepository = characterRepository,
        super(const CharacterState.loading());

  final CharacterRepository _characterRepository;

  CharacterStateLoaded get characterState => state.maybeMap(
        loaded: (state) => state,
        orElse: () => throw Exception(
          'value is not an instance of CharacterStateLoaded',
        ),
      );

  Future init({
    int page = 1,
    String status = '',
  }) async {
    state = const CharacterState.loading();
    final resultApi = await _characterRepository.characterSend(
      page: page,
      status: status,
    );
    state = resultApi.when(
      left: (failure) => const CharacterState.failed(),
      right: (resulCharacter) => CharacterState.loaded(
        page: page,
        totalPageAmount: resulCharacter.info.pages,
        characters: resulCharacter.results,
      ),
    );
    // log('$resultApi');
  }

  Future pagination({
    int page = 1,
    String status = '',
  }) async {
    if (page >= characterState.totalPageAmount) {
      return;
    }

    final resultApi = await _characterRepository.characterSend(
      page: page,
      status: status,
    );
    state = resultApi.when(
      left: (failure) => const CharacterState.failed(),
      right: (resulCharacter) => characterState.copyWith(
        page: page,
        totalPageAmount: resulCharacter.info.pages,
        characters: [
          ...characterState.characters,
          ...resulCharacter.results,
        ],
      ),
    );
    // log('$resultApi');
  }
}
