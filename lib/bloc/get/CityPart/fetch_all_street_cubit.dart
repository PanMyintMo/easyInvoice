import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/responsemodel/CityPart/Street.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'fetch_all_street_state.dart';

class FetchAllStreetCubit extends Cubit<FetchAllStreetState> {
  final UserRepository _userRepository;

  FetchAllStreetCubit(this._userRepository) : super(FetchAllStreetInitial());

  Future<void> fetchAllStreet() async {
    emit(FetchAllStreetLoading());

    try {
      final List<Street>? response = await _userRepository.fetchStreet();
      emit(FetchAllStreetSuccess(response!));
    } catch (error) {
      emit(FetchAllStreetFail(error.toString()));
    }
  }
}
