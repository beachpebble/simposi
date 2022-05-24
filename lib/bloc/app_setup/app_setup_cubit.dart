import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';
import 'package:simposi_app_v4/model/earning.dart';
import 'package:simposi_app_v4/model/generation.dart';
import 'package:simposi_app_v4/model/interest.dart';
import 'package:simposi_app_v4/model/master_data.dart';
import 'package:simposi_app_v4/repository/api_service.dart';

part 'app_setup_state.dart';

class AppSetupCubit extends Cubit<AppSetupState> {
  final ApiService _apiService;
  late MasterData _masterData;

  AppSetupCubit(ApiService apiService)
      : _apiService = apiService,
        super(AppSetupInitial());

  Future<void> load() async {
    emit(AppSetupLoading());
    try {
      _masterData = await _getMasterData();
      await Firebase.initializeApp();
      emit(AppSetupLoaded());
    } catch (e) {
      print("!!!! $e");
      emit(AppSetupError(e));
    }
  }

  MasterData get masterData => _masterData;

  Future<MasterData> _getMasterData() async {
    final response = await _apiService.dio.get(Api.API_MASTER_DATA);
    final Map? data = response.data['data'];
    var interestList = <Interest>[];
    if (data != null &&
        data.containsKey('whatYouLike') &&
        data['whatYouLike'] is List) {
      final List il = data['whatYouLike'];
      interestList = (il.map((e) => Interest.fromJson(e)).toList());
    }
    var generationList = <Generation>[];
    if (data != null &&
        data.containsKey('generationsIdentity') &&
        data['generationsIdentity'] is List) {
      final List il = data['generationsIdentity'];
      generationList = (il.map((e) => Generation.fromJson(e)).toList());
    }
    var earninigList = <Earning>[];
    if (data != null &&
        data.containsKey('whoEarn') &&
        data['whoEarn'] is List) {
      final List il = data['whoEarn'];
      earninigList = (il.map((e) => Earning.fromJson(e)).toList());
      earninigList.sort((first, second) {
        return first.sortId.compareTo(second.sortId);
      });
    }
    return MasterData({}..addAll(interestList), generationList, earninigList);
  }
}
