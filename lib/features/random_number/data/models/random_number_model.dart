import 'package:tddfullproject/features/random_number/domain/entity/random_number.dart';

class RandomNumberModel extends RandomNumber {
  RandomNumberModel({
    required String text,
    required int number,
  }) : super(text: text, number: number);

  factory RandomNumberModel.fromJson(Map<String, dynamic> json) {
    return RandomNumberModel(
      text: json['text'],
      number: (json['number'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'number': number,
    };
  }
}