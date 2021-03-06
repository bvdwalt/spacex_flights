import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_mode_handler/theme_mode_manager_interface.dart';

class ThemeModeManager implements IThemeModeManager {
  static const _key = 'user_theme_mode';

  @override
  Future<String> loadThemeMode() async {
    final _prefs = await SharedPreferences.getInstance();

    return _prefs.getString(_key);
  }

  @override
  Future<bool> saveThemeMode(String value) async {
    final _prefs = await SharedPreferences.getInstance();

    return _prefs.setString(_key, value);
  }
}