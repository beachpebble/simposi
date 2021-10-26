import 'dart:convert';
import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:simposi_app_v4/model/errors.dart';

class AuthRepository {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String? jwt;

  bool get authorized => jwt!= null && jwt?.isNotEmpty == true;

  loadAuth() async {
    developer.log('loadAuth', name: 'AuthRepository loadAuth');
    final SharedPreferences prefs = await _prefs;
    jwt = prefs.getString('access_token');
    if (jwt == null) {
      developer.log('jwt == null', name: 'AuthRepository loadAuth');
      await logout();
      return;
    }
    developer.log('jwt $jwt', name: 'AuthRepository loadAuth');
    developer.log('loadAuth complete', name: 'AuthRepository loadAuth');
  }

  saveAuth(String token) async {
    developer.log('saveAuth', name: 'AuthRepository saveAuth');
    final SharedPreferences prefs = await _prefs;
    prefs.setString('access_token', token);
    jwt = token;
  }

  Future logout() async {
    developer.log('---------------------  logout',
        name: 'AuthRepository logout');
    final SharedPreferences prefs = await _prefs;
    await prefs.remove('access_token');
    await prefs.remove('userId');
    jwt = null;
  }
}
