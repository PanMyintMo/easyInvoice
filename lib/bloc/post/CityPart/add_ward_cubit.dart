import 'package:easy_invoice/dataRequestModel/CityPart/AddWardRequestModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/responseModel/CityPart/AddWardResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'add_ward_state.dart';

class AddWardCubit extends Cubit<AddWardState> {
  final UserRepository _userRepository;

  AddWardCubit(this._userRepository) : super(AddWardInitial());

  Future<void> addWard(AddWardRequestModel addWardRequestModel) async {
    emit(AddWardLoading());
    try {
      final response = await _userRepository.addWard(addWardRequestModel);
      emit(AddWardSuccess(response));
    } catch (error) {
      emit(AddWardFail(error.toString()));
    }
  }
}
