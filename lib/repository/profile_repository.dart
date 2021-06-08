import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/model/network_response.dart';

import 'api_service.dart';

class ProfileRepository {
  final ApiService _apiService;

  ProfileRepository(this._apiService);


  Future login(String login, String password) async {
    NetworkResponse response = await _apiService.login(login, password);
    if (response is NetworkResponseError) {
      print("!!! response is NetworkResponseError");
      throw ApiException(errorType: LocalizedErrorType.AUTH, message: response.message);
    } else if (response is NetworkResponseSuccess) {
      print("!!! response is NetworkResponseSuccess");
      Map data = response.data;
      if (data.containsKey('apiAccessToken') && data['apiAccessToken'] != null) {
        await _apiService.authRepository.saveAuth(data['apiAccessToken']);
        return;
      } else {
        throw AuthException(
            message: "Login successful but does not contain token");
      }
    }
  }
}
