import 'package:easy_invoice/dataRequestModel/CityPart/AddCity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/responseModel/CityPart/AddCityResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'add_city_state.dart';

class AddCityCubit extends Cubit<AddCityState> {
  final UserRepository _userRepository;

  AddCityCubit(this._userRepository) : super(AddCityInitial());

  Future<void> addCity(AddCity addCity) async {
    emit(AddCityLoading());
    try {
      final response = await _userRepository.addCity(addCity);
      emit(AddCitySuccess(response));
    } catch (error) {
      emit(AddCityFail(error.toString()));
    }
  }
}
