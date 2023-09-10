import 'package:bloc/bloc.dart';
import 'package:easy_invoice/data/responsemodel/CityPart/Cities.dart';
import 'package:equatable/equatable.dart';

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
