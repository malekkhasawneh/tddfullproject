import 'package:equatable/equatable.dart';

class RandomNumber extends Equatable {
  final String text;
  final int number;

  RandomNumber({
    required this.text,
    required this.number,
  });

  @override
  List<Object> get props => [text, number];
}