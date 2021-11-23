import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:simposi_app_v4/model/earning.dart';
import 'package:simposi_app_v4/model/errors.dart';
import 'package:simposi_app_v4/model/event.dart';
import 'package:simposi_app_v4/model/gender.dart';
import 'package:simposi_app_v4/model/generation.dart';
import 'package:simposi_app_v4/model/group_finder_user.dart';
import 'package:simposi_app_v4/model/interest.dart';
import 'package:simposi_app_v4/model/rsvp.dart';
import 'package:simposi_app_v4/model/rsvp_status.dart';

import 'api_service.dart';

class CalendarRepository {
  final AuthApiService _apiService;

  CalendarRepository(this._apiService);

  Future<List<Rsvp>> getAllevents(DateTime from, DateTime to) async {
    Response response = await _apiService.dio.post(Api.RSVP_LIST, data: {
      'dataFrom': DateFormat('yyyy-MM-dd hh:mm:ss').format(from),
      'dataTo': DateFormat('yyyy-MM-dd hh:mm:ss').format(to),
    });
    Map? data = response.data["data"];
    if (data != null) {
      List rsvpsMap = data['rsvps'];
      List<Rsvp> rsvps = rsvpsMap.map((e) => Rsvp.fromJson(e)).toList();
      return rsvps;
    } else {
      throw ParseException(
          errorType: LocalizedErrorType.PARSE_ERROR,
          message: "Unexpected response empty data");
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
    Response response =
        await _apiService.dio.post(Api.API_UPLOAD_AVATAR, data: formData);
    Map? data = response.data;
    String? imgName = data?["data"]?['name'];
    if (imgName != null) {
      var data = {
        "image": imgName,
        "title": title,
        "description": description,
        "datetime": DateFormat('yyyy-MM-dd HH:mm:ss').format(date.toUtc()),
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
      Response response =
          await _apiService.dio.post(Api.API_NEW_EVENT, data: data);
      return response.data;
    } else {
      throw ParseException(
          errorType: LocalizedErrorType.PARSE_ERROR,
          message: "Unexpected response on image load");
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
      Response response =
          await _apiService.dio.post(Api.API_UPLOAD_AVATAR, data: formData);
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
    Response response =
        await _apiService.dio.put(Api.API_NEW_EVENT, data: data);
    return response.data;
  }

  Future<Rsvp> openRsvp(int id) async {
    Response response = await _apiService.dio.post(Api.API_RSVP_STATUS,
        data: {'id': id, 'modify_status_to': RsvpStatus.OPENED_ID});
    Map? data = response.data;
    Map<String, dynamic>? rsvpMap = data?['data']?['rsvp'];
    if (rsvpMap != null) {
      return Rsvp.fromJson(rsvpMap);
    } else {
      throw ParseException(
          errorType: LocalizedErrorType.PARSE_ERROR,
          message: "Unexpected response");
    }
  }

  Future<Rsvp> acceptRsvp(int id) async {
    Response response = await _apiService.dio.post(Api.API_RSVP_STATUS,
        data: {'id': id, 'modify_status_to': RsvpStatus.ACCEPTED_ID});
    Map? data = response.data;
    Map<String, dynamic>? rsvpMap = data?['data']?['rsvp'];
    if (rsvpMap != null) {
      return Rsvp.fromJson(rsvpMap);
    } else {
      throw ParseException(
          errorType: LocalizedErrorType.PARSE_ERROR,
          message: "Unexpected response");
    }
  }

  Future<Rsvp> declineRsvp(int id) async {
    Response response = await _apiService.dio.post(Api.API_RSVP_STATUS,
        data: {'id': id, 'modify_status_to': RsvpStatus.DECLINED_ID});
    Map? data = response.data;
    Map<String, dynamic>? rsvpMap = data?['data']?['rsvp'];
    if (rsvpMap != null) {
      return Rsvp.fromJson(rsvpMap);
    } else {
      throw ParseException(
          errorType: LocalizedErrorType.PARSE_ERROR,
          message: "Unexpected response");
    }
  }

  Future<Rsvp> cancelRsvp(int id) async {
    Response response = await _apiService.dio.post(Api.API_RSVP_STATUS,
        data: {'id': id, 'modify_status_to': RsvpStatus.CANCELED_ID});
    Map? data = response.data;
    Map<String, dynamic>? rsvpMap = data?['data']?['rsvp'];
    if (rsvpMap != null) {
      return Rsvp.fromJson(rsvpMap);
    } else {
      throw ParseException(
          errorType: LocalizedErrorType.PARSE_ERROR,
          message: "Unexpected response");
    }
  }

  Future<Event> getEvent(int id) async {
    Response response = await _apiService.dio.get(
      Api.API_EVENT + "/$id",
    );
    Map? data = response.data;
    Map<String, dynamic>? eventMap = data?['data']?['event'];
    if (eventMap != null) {
      return Event.fromJson(eventMap);
    } else {
      throw ParseException(
          errorType: LocalizedErrorType.PARSE_ERROR,
          message: "Unexpected response");
    }
  }
  Future cancelEvent(int id) async {
    Response response = await _apiService.dio.get(
      Api.API_EVENT_CANCEL + "/$id",
    );
  }

  Future checkIn({required int eventId, required int rsvpId}) async {
    await _apiService.dio
        .post(Api.API_CHECKIN, data: {"event_id": eventId, "rsvp_id": rsvpId});
  }

  Future<List<GroupFinderUser>> groupFinder(
      {required int eventId,
      required String latitude,
      required String longitude}) async {
    Response response = await _apiService.dio.post(Api.API_GROUP_FINDER, data: {
      "event_id": eventId,
      "latitude": latitude,
      "longitude": longitude
    });

    Map? data = response.data;
    List<dynamic>? grpUsers = data?['data']?['rsvp'];
    if (grpUsers != null) {
      List<GroupFinderUser> users =
          grpUsers.map((e) => GroupFinderUser.fromJson(e)).toList();
      return users;
    } else {
      throw ParseException(
          errorType: LocalizedErrorType.PARSE_ERROR,
          message: "Unexpected response");
    }
  }

  Future<List<GroupFinderUser>> refreshLocator(int id) async {
    await Future.delayed(Duration(milliseconds: 2000));
    // Response response = await _apiService.dio.post(
    //     Api.API_REFRESH_LOCATOR,
    //     data: {
    //       'id': id,
    //     });
    // Map? data = response.data;
    // List<dynamic>? userMap = data?['data']?['users'];
    // if (userMap != null) {
    //   return userMap.map((e) => GroupFinderUser.fromJson(e)).toList();
    // } else {
    //   throw ParseException(
    //       errorType: LocalizedErrorType.PARSE_ERROR, message: "Unexpected response");
    // }

    List<GroupFinderUser> list = [
      GroupFinderUser(
          id: 1,
          name: "Roman",
          imageUrl:
              "https://st2.depositphotos.com/1006318/5909/v/950/depositphotos_59095529-stock-illustration-profile-icon-male-avatar.jpg",
          latitude: 37.785839,
          longitude: -122.406410),
      GroupFinderUser(
          id: 2,
          name: "Petr",
          imageUrl: "https://html5css.ru/howto/img_avatar2.png",
          latitude: 37.785697,
          longitude: -122.406417),
      GroupFinderUser(
          id: 3,
          name: "Anna",
          imageUrl:
              "https://image.freepik.com/free-vector/portrait-of-an-african-american-woman-in-profile-avatar-of-young-black-girl_102172-418.jpg",
          latitude: 37.785834,
          longitude: -122.406480)
    ];

    return list;
  }
}
