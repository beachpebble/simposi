import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:simposi_app_v4/model/earning.dart';
import 'package:simposi_app_v4/model/gender.dart';
import 'package:simposi_app_v4/model/generation.dart';
import 'package:simposi_app_v4/model/interest.dart';
import 'package:simposi_app_v4/repository/calendar_repository.dart';

part 'event_edit_state.dart';

class EventEditCubit extends Cubit<EventEditState> {

  EventEditCubit({required this.calendarRepository}) : super(EventEditInitial());

  final CalendarRepository calendarRepository;

  String? photo;
  String? title;
  String? description;
  DateTime? dateTime;
  Set<Gender>? wantToMeetGender;
  Set<Earning>? wantToMeetEarnings;
  Set<Interest>? wantToMeetInterests;
  Set<Generation>? wantToMeetGenerations;
  bool lgbt = false;
  double? latitude;
  double? longitude;
  String?  city;
  String?  address;

  stage1({required String title, required String file, required String description, required DateTime dateTime}) {
    this.photo = file;
    this.title = title;
    this.description = description;
    this.dateTime = dateTime.toUtc();
  }

  void stage2SetLocation({
    required double latitude,
    required double longitude,
    required String city,
    required String address
  }) {
    this.latitude = latitude;
    this.longitude = longitude;
    this.city = city;
    this.address = address;
  }

  void setInterests({
    required Set<Interest> interests,
  }) async {
    this.wantToMeetInterests = interests;
  }

  void stage4Gender({
    required Set<Gender> gender,
  }) {
    this.wantToMeetGender = gender;
  }

  void stage4Lgbt({
    required bool lgbt,
  }) {
    this.lgbt = lgbt;
  }

  void stage5Generations({
    required Set<Generation> generation,
  }) async {
    this.wantToMeetGenerations = generation;
  }

  void stage6Earnings({
    required Set<Earning> earnings,
  }) async {
    this.wantToMeetEarnings = earnings;
  }

  Future<void> send() async {
    emit(EventEditLoading());

    await Future.delayed(Duration(seconds: 2));
    try {
      await calendarRepository.sendEvent(
        title: title!,
        image: photo!,
        date: dateTime!,
        description: description!,
        latitude: latitude!.toString(),
        longitude: longitude!.toString(),
        address: address?.toString() ?? "",
        city: city?.toString() ?? "",
        wantToMeetGender: wantToMeetGender!,
        wantToMeetEarnings: wantToMeetEarnings!,
        wantToMeetInterests: wantToMeetInterests!,
        wantToMeetGenerations: wantToMeetGenerations!,
        isLgbt: lgbt,
      );

      emit(EventEditSuccess());
    } catch (e) {
      emit(EventEditError(e));
    }
  }
}
