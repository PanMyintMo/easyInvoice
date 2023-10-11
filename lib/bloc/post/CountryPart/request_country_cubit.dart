import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/responseModel/CountryPart/CountryResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'request_country_state.dart';

class RequestCountryCubit extends Cubit<RequestCountryState> {
  final UserRepository _userRepository;

  RequestCountryCubit(this._userRepository) : super(RequestCountryInitial());

  Future<void> country() async {
    emit(RequestCountryLoading());
    try {
      final response = await _userRepository.fetchCountry();
      emit(RequestCountrySuccess(response!));
    } catch (error) {
      emit(RequestCountryFail(error.toString()));
    }
  }
}
