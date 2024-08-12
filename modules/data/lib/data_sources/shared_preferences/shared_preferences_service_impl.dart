import 'package:data/data_sources/shared_preferences/shared_preferences_service.dart';
import 'package:infrastructure/logger/logger_barrel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServiceImpl implements SharedPreferencesService {
  SharedPreferences? _preferences;
  Future<SharedPreferences> get _preferencesGetter async =>
      _preferences ??= await SharedPreferences.getInstance();


  SharedPreferencesServiceImpl();

  @override
  Future<void> setValue<T>({required String key, required T value}) async {
    final prefs = await _preferencesGetter;

    switch (T) {
      case bool:
        await prefs.setBool(key, value as bool);
      case String:
        await prefs.setString(key, value as String);
      case int:
        await prefs.setInt(key, value as int);
      case double:
        await prefs.setDouble(key, value as double);
      case const (List<String>):
        await prefs.setStringList(key, value as List<String>);
      case _:
        logger
            .e('[shared preferences service] set value: type is not supported');
        throw Exception('type is not supported');
    }
  }

  @override
  Future<T?> getValue<T>({required String key}) async {
    final prefs = await _preferencesGetter;

    return switch (T) {
      bool => prefs.getBool(key) as T?,
      String => prefs.getString(key) as T?,
      int => prefs.getInt(key) as T?,
      double => prefs.getDouble(key) as T?,
      const (List<String>) => prefs.getStringList(key) as T?,
      _ => null,
    };
  }

  @override
  Future<bool> remove({required String key}) async {
    final prefs = await _preferencesGetter;

    return prefs.remove(key);
  }
}
