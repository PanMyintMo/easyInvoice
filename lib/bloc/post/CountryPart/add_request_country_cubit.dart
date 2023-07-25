import 'package:bloc/bloc.dart';
import 'package:easy_invoice/data/responsemodel/CountryPart/RequestCountryResponse.dart';
import 'package:easy_invoice/dataRequestModel/CountryPart/AddCountry.dart';
import 'package:equatable/equatable.dart';

import '../../../data/userRepository/UserRepository.dart';

part 'add_request_country_state.dart';

class AddRequestCountryCubit extends Cubit<AddRequestCountryState> {
  final UserRepository _userRepository;

  AddRequestCountryCubit(this._userRepository) : super(AddRequestCountryInitial());

  Future<void> addCountry(AddCountry addCountry) async {
    emit(AddRequestCountryLoading());
    try {
      final RequestCountryResponse response = await _userRepository.addCountry(addCountry);
      emit(AddRequestCountrySuccess(response));
    } catch (error) {
      emit(AddRequestCountryFail(error.toString()));
    }
  }
}
