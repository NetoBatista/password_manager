abstract class ILocalStorageService {
  Future<bool> setString(String key, String value);

  Future<bool> setBool(String key, bool value);

  Future<String?> getString(String key);

  Future<bool?> getBool(String key);

  Future<bool> clear();
}
