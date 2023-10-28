import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/models/character/character.dart';

part 'character_state.freezed.dart';

@freezed
class CharacterState with _$CharacterState {
  const factory CharacterState.loading() = _CharacterStateLoading;
  const factory CharacterState.failed() = _CharacterStateFailed;
  const factory CharacterState.loaded({
    @Default(1) int page,
    @Default(0) int totalPageAmount,
    @Default([]) List<Result> characters,
  }) = CharacterStateLoaded;
}
