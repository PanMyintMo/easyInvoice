import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/responsemodel/CityPart/EditCityResponse.dart';
import '../../../data/userRepository/UserRepository.dart';
import '../../../dataRequestModel/CityPart/EditCity.dart';

part 'edit_city_state.dart';

class EditCityCubit extends Cubit<EditCityState> {
  final UserRepository _userRepository;

  EditCityCubit(this._userRepository) : super(EditCityInitial());

  Future<void> updateCity(int id, EditCity editCity) async {
    emit(EditCityLoading());
    try {
      final EditCityResponse response = await _userRepository.updateCity(id, editCity);
      emit(EditCitySuccess(response));
    } catch (error) {
      emit(EditCityFail(error.toString()));
    }
  }
}
