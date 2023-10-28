// To parse this JSON data, do
//
//     final location = locationFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

import '../character/character.dart';

part 'location.freezed.dart';
part 'location.g.dart';

@freezed
class LocationModel with _$LocationModel {
  const factory LocationModel({
    required Info info,
    required List<Result> results,
  }) = _LocationModel;

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
}


@freezed
class Result with _$Result {
  const factory Result({
    required int id,
    required String name,
    required String type,
    required String dimension,
    required List<String> residents,
    required String url,
    required DateTime created,
  }) = _Result;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}
