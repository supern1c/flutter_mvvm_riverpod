import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  SharedPreferences? sharedPreferences;

  final Completer<SharedPreferences> completer = Completer<SharedPreferences>();

  Future<SharedPreferences> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    completer.complete(sharedPreferences!);
    return sharedPreferences!;
  }

  Future<void> setString(String key, String value) async {
    await init();
    sharedPreferences!.setString(key, value);
  }

  Future<String?> getString(String key) async {
    await init();
    return sharedPreferences!.getString(key);
  }
}