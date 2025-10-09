import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late SharedPreferences _prefs;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // ===== Authentication =====
  bool get isLoggedIn => _prefs.getBool("isLoggedIn") ?? false;
  set isLoggedIn(bool value) => _prefs.setBool("isLoggedIn", value);

  int get role => _prefs.getInt("role") ?? 0;
  set role(int value) => _prefs.setInt("role", value);

  // ===== Memorial Dialog =====
  bool get hasSeenMemorialDialog => _prefs.getBool("hasSeenMemorialDialog") ?? false;
  set hasSeenMemorialDialog(bool value) => _prefs.setBool("hasSeenMemorialDialog", value);



  // ===== Cache Clearing =====
  Future<void> clearSession() async {
    // Only clear login-related stuff
    await _prefs.remove("isLoggedIn");
    await _prefs.remove("role");
  }

  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
