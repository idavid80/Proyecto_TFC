import 'package:shared_preferences/shared_preferences.dart';

class AuthService {


  Future<void> saveUserData(String token, String username, String email, String userID, String avatar, bool isChecked) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userID', userID);
    await prefs.setString('token', token);
    await prefs.setString('username', username);
    await prefs.setString('avatar', avatar);
    await prefs.setString('email', email);
    await prefs.setBool('isChecked', isChecked);
  }

    Future<Map<String, String?>> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString('userID');
    String? token = prefs.getString('token');
    String? avatar = prefs.getString('avatar');
    String? username = prefs.getString('username');
    String? email = prefs.getString('email');
    return {'userId':userID, 'token': token, 'username': username, 'email': email, 'avatar': avatar};
  }

    Future<Map<String, bool?>> getCheck() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isChecked = prefs.getBool('isChecked');
    return {'isChecked':isChecked};
  }
}