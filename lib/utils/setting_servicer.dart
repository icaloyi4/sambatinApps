import 'package:shared_preferences/shared_preferences.dart';

class SettingService {
  static SettingService _service;

  final SharedPreferences _keyStorage;

  SettingService(this._keyStorage);

  static Future<SettingService> getService() async {
    if (_service == null)
      _service = SettingService(await SharedPreferences.getInstance());

    return _service;
  }

  T get<T>(String key) => _keyStorage.get(key) as T;

  Future<bool> set(String key, dynamic value) async {
    if (value is int) {
      return _keyStorage.setInt(key, value);
    } else if (value is double) {
      return _keyStorage.setDouble(key, value);
    } else if (value is bool) {
      return _keyStorage.setBool(key, value);
    } else {
      return _keyStorage.setString(key, value);
    }
  }

  Future<bool> del(String key) => _keyStorage.remove(key);

}