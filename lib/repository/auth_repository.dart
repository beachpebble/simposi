import 'dart:convert';
import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:simposi_app_v4/model/errors.dart';

class AuthRepository {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String? jwt;
  String? get usedId {
    if (jwt == null) return null;
    try {
      Map jwtMap = _decodeJwt(jwt!);
      Map data = jwtMap['data'];
      return data['id'];
    } catch (e) {
      return null;
    }
  }
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
    Map payload;
    try {
      payload = _decodeJwt(jwt!);
      developer.log('payload parsed $payload', name: 'AuthRepository loadAuth');
    } catch (e) {
      await logout();
      return;
    }
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

  Map _decodeJwt(String jwt) {
    var parts = jwt.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid jwt');
    }
    Map payload;
    try {
      payload = jsonDecode(
          utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
    } catch (e) {
      throw ParseException(errorType: LocalizedErrorType.PARSE_JWT_ERROR,
          message: 'Unable to parse jwt');
    }
    return payload;
  }
}
