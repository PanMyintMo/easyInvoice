import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/responseModel/TownshipsPart/AllTownshipResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'fetch_all_township_state.dart';

class FetchAllTownshipCubit extends Cubit<FetchAllTownshipState> {
  final UserRepository _userRepository;

  FetchAllTownshipCubit(this._userRepository) : super(FetchAllTownshipInitial());

  Future<void> fetchAllTownship() async {
    emit(FetchAllTownshipLoading());

    try {
      final response = await _userRepository.fetchTownships();
      emit(FetchAllTownshipSuccess(response!));
    } catch (error) {
      emit(FetchAllTownshipFail(error.toString()));
    }
  }
}
