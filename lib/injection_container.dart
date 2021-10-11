import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';
import 'features/random_number/data/datasource/random_number_local_data_source.dart';
import 'features/random_number/data/datasource/random_number_remote_data_source.dart';
import 'features/random_number/data/repository/random_number_repository_implementation.dart';
import 'features/random_number/domain/repository/random_number_repository.dart';
import 'features/random_number/domain/usecase/get_concrete_random_number.dart';
import 'features/random_number/domain/usecase/get_random_number.dart';
import 'features/random_number/presentation/bloc/random_number_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  serviceLocator.registerFactory(() => RandomNumberBloc(
      getConcreteRandomNumber: serviceLocator(),
      getRandomNumber: serviceLocator(),
      inputConverter: serviceLocator()));

  // From Use cases
  serviceLocator.registerLazySingleton(() => GetConcreteRandomNumber(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetRandomNumber(serviceLocator()));

  // From Repository
  serviceLocator.registerLazySingleton<RandomNumberRepository>(
        () => RandomNumberRepositoryImpl(
      localDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
      remoteDataSource: serviceLocator(),
    ),
  );

  // From Data sources
  serviceLocator.registerLazySingleton<RandomNumberRemoteDataSource>(
        () => RandomNumberRemoteDataSourceImpl(client: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<RandomNumberLocalDataSource>(
        () => RandomNumberLocalDataSourceImpl(sharedPreferences: serviceLocator()),
  );

  // From Core
  serviceLocator.registerLazySingleton(() => InputConverter());
  serviceLocator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(serviceLocator()));

  // External Library
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => http.Client());
  serviceLocator.registerLazySingleton(() => DataConnectionChecker());
}
