import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'data/data_source/remote/character_api.dart';
import 'data/data_source/remote/internet_checker.dart';
import 'data/http/http.dart';
import 'data/repositories_impl/character_repository.dart';
import 'data/repositories_impl/connectivity_repository_impl.dart';
import 'domain/repositories/character_repository.dart';
import 'domain/repositories/connectivity_repository.dart';

Future<void> injectDependencies() async {}

class Repositories {
  Repositories._();

  /// [characterApi] : Api para el consumo.
  static final characterApi = Provider<CharacterRepository>(
    (ref) => CharacterRepositoryImpl(
      characterApi: CharacterApi(
        http: Http(baseUrl: 'https://rickandmortyapi.com/api'),
      ),
    ),
  );

  /// [connectivity] : ver el estado de la conexion a internet.
  static final connectivity = Provider<ConnectivityRepository>(
    (ref) => ConnectivityRepositoryImpl(
      connectivity: Connectivity(),
      internetChecker: InternetChecker(),
    ),
  );
}
