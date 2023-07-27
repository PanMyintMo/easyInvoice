import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/responsemodel/TownshipsPart/AllTownshipResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'fetch_all_township_state.dart';

class FetchAllTownshipCubit extends Cubit<FetchAllTownshipState> {
  final UserRepository _userRepository;

  FetchAllTownshipCubit(this._userRepository) : super(FetchAllTownshipInitial());

  Future<void> fetchAllTownship() async {
    emit(FetchAllTownshipLoading());

    try {
      final List<Township> response = await _userRepository.fetchTownships();
      emit(FetchAllTownshipSuccess(response));
    } catch (error) {
      emit(FetchAllTownshipFail(error.toString()));
    }
  }
}
