import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/responseModel/common/WardResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'fetch_all_ward_state.dart';

class FetchAllWardCubit extends Cubit<FetchAllWardState> {
  final UserRepository _userRepository;

  FetchAllWardCubit(this._userRepository) : super(FetchAllWardInitial());

  Future<void> fetchAllWard() async {
    emit(FetchAllWardLoading());

    try {
      final response = await _userRepository.fetchWard();
      emit(FetchAllWardSuccess(response!));
    } catch (error) {
      emit(FetchAllWardFail(error.toString()));
    }
  }
}
