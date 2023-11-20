import 'package:password_manager/core/interface/ilocal_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService implements ILocalStorageService {
  SharedPreferences? _sharedPreferences;

  Future<SharedPreferences> getInstance() async {
    if (_sharedPreferences != null) {
      return _sharedPreferences!;
    }
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }

  @override
  Future<String?> getString(String key) async {
    var instance = await getInstance();
    return instance.getString(key);
  }

  @override
  Future<bool?> getBool(String key) async {
    var instance = await getInstance();
    return instance.getBool(key);
  }

  @override
  Future<bool> setString(String key, String value) async {
    var instance = await getInstance();
    return instance.setString(key, value);
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    var instance = await getInstance();
    return instance.setBool(key, value);
  }

  @override
  Future<bool> clear() async {
    var instance = await getInstance();
    return instance.clear();
  }
}
