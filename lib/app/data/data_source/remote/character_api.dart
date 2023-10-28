import '../../../domain/either/either.dart';
import '../../../domain/models/character/character.dart';
import '../../../domain/models/episodes/episodes_model.dart';
import '../../../domain/models/failure/response_failure.dart';
import '../../../domain/models/location/location.dart';
import '../../http/http.dart';
import '../utils/handle_failure.dart';

class CharacterApi {
  CharacterApi({
    required Http http,
  }) : _http = http;
  final Http _http;

  Future<Either<ResponseFailure, Character>> characterSend({
    int page = 0,
    String status = '',
  }) async {
    final response = await _http.request(
      '/character',
      queryParameters: {
        'page': '$page',
        'status': status,
      },
      onSuccess: (result) => Character.fromJson(result),
    );
    return response.when(
      left: handleFailure,
      right: Either.right,
    );
  }

  Future<Either<ResponseFailure, LocationModel>> locationSend({
    int page = 0,
    String name = '',
  }) async {
    final response = await _http.request(
      '/location',
      queryParameters: {
        'page': '$page',
        'name': name,
      },
      onSuccess: (result) => LocationModel.fromJson(result),
    );
    return response.when(
      left: handleFailure,
      right: Either.right,
    );
  }

    Future<Either<ResponseFailure, EpisodesModel>> episodesSend({
    int page = 0,
    String name = '',
  }) async {
    final response = await _http.request(
      '/episode',
      queryParameters: {
        'page': '$page',
        'name': name,
      },
      onSuccess: (result) => EpisodesModel.fromJson(result),
    );
    return response.when(
      left: handleFailure,
      right: Either.right,
    );
  }
}
