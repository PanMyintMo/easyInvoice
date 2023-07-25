import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/responsemodel/CountryPart/CountryResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'request_country_state.dart';

class RequestCountryCubit extends Cubit<RequestCountryState> {
  final UserRepository _userRepository;

  RequestCountryCubit(this._userRepository) : super(RequestCountryInitial());

  Future<void> country() async {
    emit(RequestCountryLoading());
    try {
      final List<Country> response = await _userRepository.fetchCountry();
      emit(RequestCountrySuccess(response));
    } catch (error) {
      emit(RequestCountryFail(error.toString()));
    }
  }
}
