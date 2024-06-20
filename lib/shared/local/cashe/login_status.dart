import 'package:shared_preferences/shared_preferences.dart';

class LoginStatus {
  static Future<void> saveLoginStatus({
    required String token,
    required String role,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('role', role);
    await prefs.setBool('isLoggedIn', true);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<String> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    print('preefs  ${prefs.getString('role')}');
    return prefs.getString('role')!;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('role');
    await prefs.setBool('isLoggedIn', false);
  }
}
