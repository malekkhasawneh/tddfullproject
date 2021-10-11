import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tddfullproject/features/random_number/domain/entity/random_number.dart';

@immutable
abstract class RandomNumberState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends RandomNumberState {}

class Loading extends RandomNumberState {}

class Loaded extends RandomNumberState {
  final RandomNumber random;

  Loaded({required this.random});

  @override
  List<Object> get props => [random];
}

class Error extends RandomNumberState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}