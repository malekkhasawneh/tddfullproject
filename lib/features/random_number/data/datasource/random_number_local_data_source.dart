import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tddfullproject/core/error/exceptions.dart';
import 'package:tddfullproject/features/random_number/data/models/random_number_model.dart';


abstract class RandomNumberLocalDataSource {
  Future<RandomNumberModel> getLastRandomNumber();

  Future<void> cacheRandomNumber(RandomNumberModel randomToCache);
}

const CACHED_RANDOM_NUMBER = 'CACHED_RANDOM_NUMBER';

class RandomNumberLocalDataSourceImpl implements RandomNumberLocalDataSource {
  final SharedPreferences sharedPreferences;

  RandomNumberLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<RandomNumberModel> getLastRandomNumber() {
    final jsonString = sharedPreferences.getString(CACHED_RANDOM_NUMBER);
    if (jsonString != null) {
      return Future.value(RandomNumberModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheRandomNumber(RandomNumberModel randomToCache) {
    return sharedPreferences.setString(
      CACHED_RANDOM_NUMBER,
      json.encode(randomToCache.toJson()),
    );
  }
}
