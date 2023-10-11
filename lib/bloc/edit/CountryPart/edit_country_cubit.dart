import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/responseModel/CountryPart/EditCountryResponse.dart';
import '../../../data/userRepository/UserRepository.dart';
import '../../../dataRequestModel/CountryPart/EditCountry.dart';

part 'edit_country_state.dart';

class EditCountryCubit extends Cubit<EditCountryState> {
  final UserRepository _userRepository;

  EditCountryCubit(this._userRepository) : super(EditCountryInitial());

  Future<void> updateCountry(int id, EditCountry editCountry) async {
    emit(EditCountryLoading());
    try {
      final EditCountryResponse response = await _userRepository.updateCountry(id, editCountry);
      emit(EditCountrySuccess(response));
    } catch (error) {
      emit(EditCountryFail(error.toString()));
    }
  }
}
