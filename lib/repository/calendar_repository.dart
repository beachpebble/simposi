import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:simposi_app_v4/model/earning.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/model/gender.dart';
import 'package:simposi_app_v4/model/generation.dart';
import 'package:simposi_app_v4/model/interest.dart';
import 'package:simposi_app_v4/model/rsvp.dart';

import 'api_service.dart';

class CalendarRepository {
  final ApiService _apiService;

  CalendarRepository(this._apiService);

  Future<List<Rsvp>> getAllevents(DateTime from, DateTime to)  async {
    Response response =
        await _apiService.post(ApiService.RSVP_LIST, auth: true, data:{
          'dataFrom': DateFormat('yyyy-MM-dd hh:mm:ss').format(from),
          'dataTo': DateFormat('yyyy-MM-dd hh:mm:ss').format(to),
        });
    Map? data = response.data["data"];
    if (data != null) {
      List rsvpsMap = data['rsvps'];
      List<Rsvp> rsvps =  rsvpsMap.map((e) => Rsvp.fromJson(e)).toList();
      return rsvps;
    } else {
      throw ApiException(
          errorType: LocalizedErrorType.OTHER, message: "Unexpected response empty data");
    }
  }

  Future sendEvent({
    required String title,
    required String image,
    required String description,
    required DateTime date,
    required String latitude,
    required String longitude,
    required String address,
    required String city,
    required bool isLgbt,
    required Set<Gender> wantToMeetGender,
    required Set<Earning> wantToMeetEarnings,
    required Set<Interest> wantToMeetInterests,
    required Set<Generation> wantToMeetGenerations,
  }) async {

    String fileName = image.split('/').last;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        image,
        filename: fileName,
        contentType: MediaType("image", "jpeg"),
      ),
    });
    Response response = await _apiService.postMulti(
        ApiService.API_UPLOAD_AVATAR,
        data: formData,
        lang: false,
        auth: false);
    Map? data = response.data;
    String? imgName = data?["data"]?['name'];
    if (imgName != null) {

      var data = {
        "image": imgName,
        "title": title,
        "description": description,
        "datetime": DateFormat('yyyy-MM-dd hh:mm:ss').format(date),
        "latitude": latitude,
        "longitude": longitude,
        "location_name": address,
        "location_address": address,
        "location_city": city,
        "covid": true,
        "is_lgbtq": isLgbt,
        "status": "Upcoming",
        "generations": wantToMeetGenerations.map((e) => e.id).toList(),
        "want_to_meets": wantToMeetGender.map((e) => e.id).toList(),
        "what_you_likes": wantToMeetInterests.map((e) => e.id).toList(),
        "who_earns": wantToMeetEarnings.map((e) => e.id).toList(),
      };
      Response response = await _apiService.post(ApiService.API_NEW_EVENT,
          auth: true, data: data);
      return response.data;


    } else {
      throw ApiException(
          errorType: LocalizedErrorType.OTHER, message: "Unexpected response on image load");
    }

  }

  Future editEvent({
    required int id,
    required String title,
    required String? image,
    required String description,
    required DateTime date,
    required String latitude,
    required String longitude,
    required String address,
    required String city,
    required bool isLgbt,
    required Set<Gender> wantToMeetGender,
    required Set<Earning> wantToMeetEarnings,
    required Set<Interest> wantToMeetInterests,
    required Set<Generation> wantToMeetGenerations,
  }) async {

    String? imgName;
    if (image != null) {
      String fileName = image.split('/').last;
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          image,
          filename: fileName,
          contentType: MediaType("image", "jpeg"),
        ),
      });
      Response response = await _apiService.postMulti(
          ApiService.API_UPLOAD_AVATAR,
          data: formData,
          lang: false,
          auth: false);
      Map? data = response.data;
      imgName = data?["data"]?['name'];
    }

    var data = {
      'id': id,
      "title": title,
      "description": description,
      "datetime": DateFormat('yyyy-MM-dd hh:mm:ss').format(date),
      "latitude": latitude,
      "longitude": longitude,
      "location_name": address,
      "location_address": address,
      "location_city": city,
      "covid": true,
      "is_lgbtq": isLgbt,
      "status": "Upcoming",
      "generations": wantToMeetGenerations.map((e) => e.id).toList(),
      "want_to_meets": wantToMeetGender.map((e) => e.id).toList(),
      "what_you_likes": wantToMeetInterests.map((e) => e.id).toList(),
      "who_earns": wantToMeetEarnings.map((e) => e.id).toList(),
    };
    if (imgName != null) {
      data['image'] = imgName;
    }
    Response response = await _apiService.put(ApiService.API_NEW_EVENT,
        auth: true, data: data);
    return response.data;
  }

}