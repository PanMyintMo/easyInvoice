import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/responseModel/CityPart/Cities.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'fetch_all_city_state.dart';

class FetchAllCityCubit extends Cubit<FetchAllCityState> {
  final UserRepository _userRepository;

  FetchAllCityCubit(this._userRepository) : super(FetchAllCityInitial());

  Future<void> fetchAllCity() async {
    emit(FetchAllCityLoading());

    try {
      final List<City>? response = await _userRepository.fetchCity();
      emit(FetchAllCitySuccess(response!));
    } catch (error) {
      emit(FetchAllCityFail(error.toString()));
    }
  }
}
