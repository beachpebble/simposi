import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/authentication/createprofile/cubit/registration_cubit.dart';
import 'package:simposi_app_v4/model/interest.dart';

part 'signup5_activities_state.dart';

class Signup5ActivitiesCubit extends Cubit<Signup5ActivitiesState> {
  final RegistrationCubit registrationCubit;

  Signup5ActivitiesCubit(this.interests, this.registrationCubit)
      : super(Signup5ActivitiesState(
      interests: interests,
      filtered: interests,
      selected: registrationCubit.interests ?? {}));

  final Set<Interest> interests;

  Future<void> selectInterest(Interest interest) async {
    Set<Interest> newSelected = {};
    newSelected.addAll(state.selected);
    newSelected.add(interest);
    emit(state.copyWith(selected: newSelected));
    registrationCubit.setInterests(interests: newSelected);
  }

  Future<void> deselectInterest(Interest interest) async {
    Set<Interest> newSelected = {};
    newSelected.addAll(state.selected);
    newSelected.remove(interest);
    emit(state.copyWith(selected: newSelected));
    registrationCubit.setInterests(interests: newSelected);
  }

  Future<void> search(String search) async {
    Set<Interest> newFiltered = {}..addAll(state.interests.where((element) =>
        element.title.toLowerCase().contains(search.toLowerCase())));

    //clean selected not in filter
    Set<Interest> newSelected = {}..removeWhere((element) =>
    !element.title.toLowerCase().contains(search.toLowerCase()));

    emit(state.copyWith(filtered: newFiltered));
  }
}
