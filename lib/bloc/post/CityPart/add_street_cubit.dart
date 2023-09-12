import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/responsemodel/CityPart/AddStreetResponse.dart';
import '../../../data/userRepository/UserRepository.dart';
import '../../../dataRequestModel/CityPart/AddStreetRequestModel.dart';

part 'add_street_state.dart';

class AddStreetCubit extends Cubit<AddStreetState> {
  final UserRepository _userRepository;

  AddStreetCubit(this._userRepository) : super(AddStreetInitial());

  Future<void> addStreet(AddStreetRequestModel addStreetRequestModel) async {
    emit(AddStreetLoading());
    try {
      final AddStreetResponse response = await _userRepository.addStreet(addStreetRequestModel);
      emit(AddStreetSuccess(response));
    } catch (error) {
      emit(AddStreetFail(error.toString()));
    }
  }
}
