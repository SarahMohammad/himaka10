import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:himaka/Models/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveLoginData(String user) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('UserData', user);
}
Future<LoginUserResponse> isLogin() async {
  final prefs = await SharedPreferences.getInstance();
  String user = prefs.get('UserData') ?? null;
  if (user != null) {
    return LoginUserResponse.fromJson(json.decode(user));
  }
  return null;
}



saveDeviceToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('FCMToken', token);
}

onBoard() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('on_board_screen', true);
}
deleteCart() async {
  final _storage = FlutterSecureStorage();
  await _storage.deleteAll();
}


//Future<int> isFirstTime() async {
//  var prefs = await SharedPreferences.getInstance();
//  if (prefs.getBool('on_board_screen') != null) {
//    String user = prefs.get('UserData') ?? null;
//    if (user != null) {
//      Globals.userData = UserData.fromJson(json.decode(user));
//      return 2;
//    }
//    return 3;
//  }
//  return 1;
//}

Future<String> fetchFCMToken() async {
  var prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('FCMToken');
  if (token != null) {
    return token;
  }
  return '';
}

Future<bool> removeUserData() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('UserData');
  deleteCart();
  return true;
}
