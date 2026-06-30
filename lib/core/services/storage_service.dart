import 'package:shared_preferences/shared_preferences.dart';

/// Thin wrapper around SharedPreferences used for persisting auth state
/// across app launches so we never ask a logged-in user to sign in twice.
class StorageService {
  static const String _kLoggedIn = 'is_logged_in';

  Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kLoggedIn, value);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kLoggedIn) ?? false;
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kLoggedIn);
  }
}
