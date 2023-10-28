import 'package:freezed_annotation/freezed_annotation.dart';

import '../character/character.dart';

part 'episodes_model.freezed.dart';
part 'episodes_model.g.dart';

@freezed
class EpisodesModel with _$EpisodesModel {
    const factory EpisodesModel({
        required Info info,
        required List<Result> results,
    }) = _EpisodesModel;

    factory EpisodesModel.fromJson(Map<String, dynamic> json) => _$EpisodesModelFromJson(json);
}

@freezed
class Result with _$Result {
    const factory Result({
        required int id,
        required String name,
        @JsonKey(name: 'air_date') required String airDate,
        required String episode,
        required List<String> characters,
        required String url,
        required DateTime created,
    }) = _Result;

    factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}
