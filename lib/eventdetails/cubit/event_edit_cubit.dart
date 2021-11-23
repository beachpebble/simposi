import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/model/earning.dart';
import 'package:simposi_app_v4/model/event.dart';
import 'package:simposi_app_v4/model/gender.dart';
import 'package:simposi_app_v4/model/generation.dart';
import 'package:simposi_app_v4/model/interest.dart';
import 'package:simposi_app_v4/repository/calendar_repository.dart';

part 'event_edit_state.dart';

class EventEditCubit extends Cubit<EventEditState> {
  EventEditCubit({required this.calendarRepository})
      : super(EventEditInitial());

  final CalendarRepository calendarRepository;

  int? id;
  String? photo;
  String? photoUrl;
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
  String? city;
  String? address;

  bool editMode = false;

  stage1(
      {required String title,
      required String? file,
      required String? url,
      required String description,
      required DateTime dateTime}) {
    this.photo = file;
    this.title = title;
    this.description = description;
    this.dateTime = dateTime.toUtc();
  }

  void stage2SetLocation(
      {required double latitude,
      required double longitude,
      required String city,
      required String address}) {
    print("WTF");
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

  Future<void> complete() {
    if (editMode) {
      return sendEdit();
    } else {
      return sendCreate();
    }
  }

  Future<void> sendCreate() async {
    emit(EventEditLoading());
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
      reset();
      emit(EventEditSuccess());
    } catch (e) {
      emit(EventEditError(e));
    }
  }

  Future<void> sendEdit() async {
    emit(EventEditLoading());
    try {
      await calendarRepository.editEvent(
        id: id!,
        title: title!,
        image: photo,
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
      reset();
      emit(EventEditSuccess());
    } catch (e) {
      emit(EventEditError(e));
    }
  }

  void reset() {
    id = null;
    photo = null;
    photoUrl = null;
    title = null;
    description = null;
    dateTime = null;
    wantToMeetGender = null;
    wantToMeetEarnings = null;
    wantToMeetInterests = null;
    wantToMeetGenerations = null;
    lgbt = false;
    latitude = null;
    longitude = null;
    city = null;
    address = null;
  }

  void initCreate() {
    reset();
  }

  void initEdit(Event event) {
    id = event.id;
    editMode = true;
    photoUrl = event.image.url;
    title = event.title;
    description = event.description;
    dateTime = event.datetime.toLocal();
    wantToMeetGender = event.wantToMeetGenders.toSet();
    wantToMeetEarnings = event.wantToMeetEarnings.toSet();
    wantToMeetInterests = event.wantToMeetInterests.toSet();
    wantToMeetGenerations = event.wantToMeetGenerations.toSet();
    lgbt = event.isLgbt;
    latitude = double.tryParse(event.latitude);
    longitude = double.tryParse(event.longitude);
    city = event.locationCity;
    address = event.locationAddress;
  }
}
