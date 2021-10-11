import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tddfullproject/core/error/exceptions.dart';
import 'package:tddfullproject/features/random_number/data/models/random_number_model.dart';


abstract class RandomNumberRemoteDataSource {
  Future<RandomNumberModel> getConcreteRandomNumber(int number);

  Future<RandomNumberModel> getRandomNumber();
}

class RandomNumberRemoteDataSourceImpl implements RandomNumberRemoteDataSource {
  final http.Client client;

  RandomNumberRemoteDataSourceImpl({required this.client});

  @override
  Future<RandomNumberModel> getConcreteRandomNumber(int number) =>
      _geRandomNumberFromUrl('http://numbersapi.com/$number?json');

  @override
  Future<RandomNumberModel> getRandomNumber() =>
      _geRandomNumberFromUrl('http://numbersapi.com/random?json');

  Future<RandomNumberModel> _geRandomNumberFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      return RandomNumberModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}