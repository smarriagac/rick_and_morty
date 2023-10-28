// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episodes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EpisodesModelImpl _$$EpisodesModelImplFromJson(Map<String, dynamic> json) =>
    _$EpisodesModelImpl(
      info: Info.fromJson(json['info'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>)
          .map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$EpisodesModelImplToJson(_$EpisodesModelImpl instance) =>
    <String, dynamic>{
      'info': instance.info,
      'results': instance.results,
    };

_$ResultImpl _$$ResultImplFromJson(Map<String, dynamic> json) => _$ResultImpl(
      id: json['id'] as int,
      name: json['name'] as String,
      airDate: json['air_date'] as String,
      episode: json['episode'] as String,
      characters: (json['characters'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      url: json['url'] as String,
      created: DateTime.parse(json['created'] as String),
    );

Map<String, dynamic> _$$ResultImplToJson(_$ResultImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'air_date': instance.airDate,
      'episode': instance.episode,
      'characters': instance.characters,
      'url': instance.url,
      'created': instance.created.toIso8601String(),
    };
