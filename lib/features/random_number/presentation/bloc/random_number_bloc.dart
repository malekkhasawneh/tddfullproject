import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:dartz/dartz.dart';
import 'package:tddfullproject/core/error/failure.dart';
import 'package:tddfullproject/core/usecase/usecase.dart';
import 'package:tddfullproject/core/util/input_converter.dart';
import 'package:tddfullproject/features/random_number/domain/entity/random_number.dart';
import 'package:tddfullproject/features/random_number/domain/usecase/get_concrete_random_number.dart';
import 'package:tddfullproject/features/random_number/domain/usecase/get_random_number.dart';
import 'package:tddfullproject/features/random_number/presentation/bloc/random_number_event.dart';
import 'package:tddfullproject/features/random_number/presentation/bloc/random_number_state.dart';


const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class RandomNumberBloc extends Bloc<RandomNumberEvent, RandomNumberState> {
  final GetConcreteRandomNumber getConcreteRandomNumber;
  final GetRandomNumber getRandomNumber;
  final InputConverter inputConverter;

  RandomNumberBloc({
    required this.getConcreteRandomNumber,
    required this.getRandomNumber,
    required this.inputConverter,
  }):super(Empty());

  @override
  Stream<RandomNumberState> mapEventToState(RandomNumberEvent event,) async* {
    if (event is GetRandomForConcreteNumber) {
      final inputEither =
      inputConverter.stringToInteger(event.numberString);

      yield* inputEither.fold(
            (failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
            (integer) async* {
          yield Loading();
          final failureOrTrivia =
          await getConcreteRandomNumber(Params(number: integer));
          yield* _eitherLoadedOrErrorState(failureOrTrivia);
        },
      );
    } else if (event is GetForRandomNumber) {
      yield Loading();
      final failureOrRandom = await getRandomNumber(NoParameters());
      yield* _eitherLoadedOrErrorState(failureOrRandom);
    }
  }

  Stream<RandomNumberState> _eitherLoadedOrErrorState(
      Either<Failure, RandomNumber> failureOrTrivia,) async* {
    yield failureOrTrivia.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (random) => Loaded( random: random),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}