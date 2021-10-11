import 'package:dartz/dartz.dart';
import 'package:tddfullproject/core/error/exceptions.dart';
import 'package:tddfullproject/core/error/failure.dart';
import 'package:tddfullproject/core/network/network_info.dart';
import 'package:tddfullproject/features/random_number/data/datasource/random_number_local_data_source.dart';
import 'package:tddfullproject/features/random_number/data/datasource/random_number_remote_data_source.dart';
import 'package:tddfullproject/features/random_number/data/models/random_number_model.dart';
import 'package:tddfullproject/features/random_number/domain/entity/random_number.dart';
import 'package:tddfullproject/features/random_number/domain/repository/random_number_repository.dart';


typedef Future<RandomNumberModel> _ConcreteOrRandomChooser();

class RandomNumberRepositoryImpl implements RandomNumberRepository {
  final RandomNumberRemoteDataSource remoteDataSource;
  final RandomNumberLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  RandomNumberRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, RandomNumber>> getConcreteRandomNumber(
      int number,
      ) async {
    return await _getRandomNumber(() {
      return remoteDataSource.getConcreteRandomNumber(number);
    });
  }

  @override
  Future<Either<Failure, RandomNumber>> getRandomNumber() async {
    return await _getRandomNumber(() {
      return remoteDataSource.getRandomNumber();
    });
  }

  Future<Either<Failure, RandomNumber>> _getRandomNumber(
      _ConcreteOrRandomChooser getConcreteOrRandom,
      ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRandom = await getConcreteOrRandom();
        localDataSource.cacheRandomNumber(remoteRandom);
        return Right(remoteRandom);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localRandom = await localDataSource.getLastRandomNumber();
        return Right(localRandom);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}