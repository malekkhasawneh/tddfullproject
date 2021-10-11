import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RandomNumberEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetRandomForConcreteNumber extends RandomNumberEvent {
  final String numberString;

  GetRandomForConcreteNumber(this.numberString);

  @override
  List<Object> get props => [numberString];
}

class GetForRandomNumber extends RandomNumberEvent {}