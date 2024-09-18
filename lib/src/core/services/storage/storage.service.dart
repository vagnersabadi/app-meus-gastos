import 'package:shared_preferences/shared_preferences.dart';

enum SharedPreferencesKeys {
  isLoggedIn,
  userLogin,
}

class StorageService {
  static SharedPreferences? _preferences;

  static Future<void> _getPreferences() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  static Future<void> saveBool(SharedPreferencesKeys key, bool value) async {
    await _getPreferences();
    await _preferences!.setBool(key.toString(), value);
  }

  static Future<bool?> getBool(SharedPreferencesKeys key) async {
    await _getPreferences();
    return _preferences!.getBool(key.toString());
  }

  static Future<void> saveString(SharedPreferencesKeys key, String value) async {
    await _getPreferences();
    await _preferences!.setString(key.toString(), value);
  }

  static Future<String?> getString(SharedPreferencesKeys key) async {
    await _getPreferences();
    return _preferences!.getString(key.toString());
  }

  static Future<void> saveStringList(SharedPreferencesKeys key, List<String> value) async {
    await _getPreferences();
    await _preferences!.setStringList(key.toString(), value);
  }

  static Future<List<String>?> getStringList(SharedPreferencesKeys key) async {
    await _getPreferences();
    return _preferences!.getStringList(key.toString());
  }
}
