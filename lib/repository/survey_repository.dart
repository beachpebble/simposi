import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/model/survey.dart';
import 'package:simposi_app_v4/model/survey_required.dart';

import 'api_service.dart';

class SurveyRepository {
  final AuthApiService _apiService;

  SurveyRepository(this._apiService);

  Future<List<SurveyRequired>> getAllSurveyRequests() async {
    final response = await _apiService.dio.get(Api.apiGetSurveyRequests);
    final Map? data = response.data["data"];
    if (data != null) {
      final List surveysMap = data['surveys'];
      final surveys = surveysMap.map((e) => SurveyRequired.fromJson(e)).toList();
      return surveys;
    } else {
      throw ParseException(
          errorType: LocalizedErrorType.PARSE_ERROR,
          message: "Unexpected response empty data surveys");
    }
  }

  Future submitSurvey(Survey survey) async {
    await _apiService.dio.post(Api.apiSendSurvey);
  }
}