import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/models/episodes/episodes_model.dart';

part 'episodes_state.freezed.dart';

@freezed
class EpisodesState with _$EpisodesState {
  const factory EpisodesState.loading() = _EpisodesStateLoading;
  const factory EpisodesState.failed() = _EpisodesStateFailed;
  const factory EpisodesState.loaded(EpisodesModel state) =
      _EpisodesStateLoaded;
}
