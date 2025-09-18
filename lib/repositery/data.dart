import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString('email');
    final storedPassword = prefs.getString('password');
    if (storedEmail == email && storedPassword == password) {
      await prefs.setBool('isLoggedIn', true);
      return true;
    }
    return false;
  }

  Future<bool> signup(String name, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setBool('isLoggedIn', true);
    return true;
  }
}