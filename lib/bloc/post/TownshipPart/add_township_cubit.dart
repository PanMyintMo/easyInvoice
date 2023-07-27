import 'package:bloc/bloc.dart';
import 'package:easy_invoice/dataRequestModel/TownshipPart/AddTownship.dart';
import 'package:equatable/equatable.dart';

import '../../../data/responsemodel/TownshipsPart/AddTownshipResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'add_township_state.dart';

class AddTownshipCubit extends Cubit<AddTownshipState> {
  final UserRepository _userRepository;

  AddTownshipCubit(this._userRepository) : super(AddTownshipInitial());

  Future<void> addTownship(AddTownship addTownship) async {
    emit(AddTownshipLoading());
    try {
      final AddTownshipResponse response = await _userRepository.addTownship(addTownship);
      emit(AddTownshipSuccess(response));
    } catch (error) {
      emit(AddTownshipFail(error.toString()));
    }
  }
}