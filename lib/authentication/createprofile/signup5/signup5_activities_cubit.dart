import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simposi_app_v4/model/interest.dart';

part 'signup5_activities_state.dart';

class Signup6ActivitiesCubit extends Cubit<Signup6ActivitiesState> {
  Signup6ActivitiesCubit(this.interests) : super(Signup6ActivitiesState(interests: interests, filtered: interests));

  final Set<Interest> interests;

  Future<void> selectInterest(Interest interest) async {
    Set<Interest> newSelected = {
    };
    newSelected.addAll(state.selected);
    newSelected.add(interest);
    emit(state.copyWith(selected: newSelected));
  }

  Future<void> deselectInterest(Interest interest) async {
    Set<Interest> newSelected = {
    };
    newSelected.addAll(state.selected);
    newSelected.remove(interest);
    emit(state.copyWith(selected: newSelected));
  }

  Future<void> search(String search) async {
    Set<Interest> newFiltered = {
    }..addAll(state.interests.where((element) => element.title.toLowerCase().contains(search.toLowerCase())));

    //clean selected not in filter
    Set<Interest> newSelected = {
    }..removeWhere((element) => !element.title.toLowerCase().contains(search.toLowerCase()));

    emit(state.copyWith(filtered: newFiltered));

  }


}
