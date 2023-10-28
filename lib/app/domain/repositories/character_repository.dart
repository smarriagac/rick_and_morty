import '../either/either.dart';
import '../models/character/character.dart';
import '../models/episodes/episodes_model.dart';
import '../models/failure/response_failure.dart';
import '../models/location/location.dart';

abstract class CharacterRepository {
  Future<Either<ResponseFailure, Character>> characterSend({
    int page = 0,
    String status = '',
  });

  Future<Either<ResponseFailure, LocationModel>> locationSend({
    int page = 0,
    String name = '',
  });

  Future<Either<ResponseFailure, EpisodesModel>> episodesSend({
    int page = 0,
    String name = '',
  });
}
