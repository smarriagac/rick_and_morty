import 'dart:developer';

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

  Future init({
    int page = 1,
    String status = '',
  }) async {
    log(status);
    state = const CharacterState.loading();
    final resultApi = await _characterRepository.characterSend(
      page: page,
      status: status,
    );
    state = resultApi.when(
      left: (failure) => const CharacterState.failed(),
      right: (value) => CharacterState.loaded(value),
    );
    // log('$resultApi');
  }
}
