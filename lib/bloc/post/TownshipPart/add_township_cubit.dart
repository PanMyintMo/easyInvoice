import 'package:easy_invoice/dataRequestModel/TownshipPart/AddTownship.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/responseModel/TownshipsPart/AddTownshipResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'add_township_state.dart';

class AddTownshipCubit extends Cubit<AddTownshipState> {
  final UserRepository _userRepository;

  AddTownshipCubit(this._userRepository) : super(AddTownshipInitial());

  Future<void> addTownship(AddTownship addTownship) async {
    emit(AddTownshipLoading());
    try {
      final response = await _userRepository.addTownship(addTownship);
      emit(AddTownshipSuccess(response));
    } catch (error) {
      emit(AddTownshipFail(error.toString()));
    }
  }
}