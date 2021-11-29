import 'package:dio/dio.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/model/survey_required.dart';

import 'api_service.dart';

class SurveyRepository {
  final AuthApiService _apiService;

  SurveyRepository(this._apiService);

  Future<List<SurveyRequired>> getAllSurveyRequests() async {
    Response response = await _apiService.dio.post(Api.API_GET_SURVEY_REQUESTS);
    Map? data = response.data["data"];
    if (data != null) {
      List surveysMap = data['surveys'];
      List<SurveyRequired> surveys = surveysMap.map((e) => SurveyRequired.fromJson(e)).toList();
      return surveys;
    } else {
      throw ParseException(
          errorType: LocalizedErrorType.PARSE_ERROR,
          message: "Unexpected response empty data surveys");
    }
  }
}