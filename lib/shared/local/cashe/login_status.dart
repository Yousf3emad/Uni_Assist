import 'package:shared_preferences/shared_preferences.dart';

class LoginStatus {
  static Future<void> saveLoginStatus({
    required String token,
    required String role,
    List<String>? subjects,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('role', role);
    await prefs.setBool('isLoggedIn', true);
    await prefs.setStringList('subjects', subjects ?? []);
    DateTime now = DateTime.now();
    prefs.setString('savedTime', now.toIso8601String());
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

  static Future<List<String>> getSubjects() async {
    final prefs = await SharedPreferences.getInstance();
    print('preefs  ${prefs.getStringList('subjects')}');
    return prefs.getStringList('subjects') ?? [];
  }

  static Future<void> saveWeekNum({
    required int weekNum,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("weekNum", weekNum);
  }

  static Future<int?> getWeekNum() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getInt("weekNum") ?? 0;
  }


  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('role');
    await prefs.setBool('isLoggedIn', false);
  }
}
