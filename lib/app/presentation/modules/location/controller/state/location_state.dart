import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/models/location/location.dart';

part 'location_state.freezed.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState.loading() = _LocationStateLoading;
  const factory LocationState.failed() = _LocationStateFailed;
  const factory LocationState.loaded(LocationModel state) =
      _LocationStateLoaded;
}
