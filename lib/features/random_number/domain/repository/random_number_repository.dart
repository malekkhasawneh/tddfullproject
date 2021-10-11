import 'package:dartz/dartz.dart';
import 'package:tddfullproject/core/error/failure.dart';
import 'package:tddfullproject/features/random_number/domain/entity/random_number.dart';

abstract class RandomNumberRepository {
  Future<Either<Failure, RandomNumber>> getConcreteRandomNumber(int number);

  Future<Either<Failure, RandomNumber>> getRandomNumber();
}
