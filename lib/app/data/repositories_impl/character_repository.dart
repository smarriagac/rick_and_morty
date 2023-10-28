import '../../domain/either/either.dart';
import '../../domain/models/character/character.dart';
import '../../domain/models/episodes/episodes_model.dart';
import '../../domain/models/failure/response_failure.dart';
import '../../domain/models/location/location.dart';
import '../../domain/repositories/character_repository.dart';
import '../data_source/remote/character_api.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  CharacterRepositoryImpl({required CharacterApi characterApi})
      : _characterApi = characterApi;

  final CharacterApi _characterApi;

  @override
  Future<Either<ResponseFailure, Character>> characterSend({
    int page = 0,
    String status = '',
  }) async {
    if (status.contains('all')) {
      status = '';
    }

    final result = await _characterApi.characterSend(
      page: page,
      status: status,
    );
    return result.when(
      left: Either.left,
      right: Either.right,
    );
  }

  @override
  Future<Either<ResponseFailure, LocationModel>> locationSend({
    int page = 0,
    String name = '',
  }) async {
    final result = await _characterApi.locationSend(
      page: page,
      name: name,
    );
    return result.when(
      left: Either.left,
      right: Either.right,
    );
  }

  @override
  Future<Either<ResponseFailure, EpisodesModel>> episodesSend({
    int page = 0,
    String name = '',
  }) async {
    final result = await _characterApi.episodesSend(
      page: page,
      name: name,
    );
    return result.when(
      left: Either.left,
      right: Either.right,
    );
  }
}
