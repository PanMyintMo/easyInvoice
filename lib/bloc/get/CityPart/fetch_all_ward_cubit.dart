import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/responsemodel/CityPart/Wards.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'fetch_all_ward_state.dart';

class FetchAllWardCubit extends Cubit<FetchAllWardState> {
  final UserRepository _userRepository;

  FetchAllWardCubit(this._userRepository) : super(FetchAllWardInitial());

  Future<void> fetchAllWard() async {
    emit(FetchAllWardLoading());

    try {
      final List<Ward>? response = await _userRepository.fetchWard();
      emit(FetchAllWardSuccess(response!));
    } catch (error) {
      emit(FetchAllWardFail(error.toString()));
    }
  }
}
