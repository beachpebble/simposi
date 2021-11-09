import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:simposi_app_v4/model/earning.dart';
import 'package:simposi_app_v4/model/generation.dart';
import 'package:simposi_app_v4/model/interest.dart';
import 'package:simposi_app_v4/model/master_data.dart';
import 'package:simposi_app_v4/repository/api_service.dart';

part 'app_setup_state.dart';

class AppSetupCubit extends Cubit<AppSetupState> {
  ApiService _apiService;
  late MasterData _masterData;

  AppSetupCubit(ApiService apiService)
      : _apiService = apiService,
        super(AppSetupInitial());

  Future<void> load() async {
    emit(AppSetupLoading());
    try {
      _masterData = await _getMasterData();
      emit(AppSetupLoaded());
    } catch (e) {
      print("!!!! $e");
      emit(AppSetupError(e));
    }
  }

  MasterData get masterData => _masterData;

  Future<MasterData> _getMasterData() async {
    Response response =
        await _apiService.dio.get(Api.API_MASTER_DATA);
    Map? data = response.data['data'];
    List<Interest> interestList = [];
    if (data != null &&
        data.containsKey('whatYouLike') &&
        data['whatYouLike'] is List) {
      List il = data['whatYouLike'];
      interestList = (il.map((e) => Interest.fromJson(e)).toList());
    }
    List<Generation> generationList = [];
    if (data != null &&
        data.containsKey('generationsIdentity') &&
        data['generationsIdentity'] is List) {
      List il = data['generationsIdentity'];
      generationList = (il.map((e) => Generation.fromJson(e)).toList());
    }
    List<Earning> earninigList = [];
    if (data != null &&
        data.containsKey('whoEarn') &&
        data['whoEarn'] is List) {
      List il = data['whoEarn'];
      earninigList = (il.map((e) => Earning.fromJson(e)).toList());
      earninigList.sort((first, second) {
        return first.sortId.compareTo(second.sortId);
      });
    }
    return MasterData({}..addAll(interestList), generationList, earninigList);
  }
}
