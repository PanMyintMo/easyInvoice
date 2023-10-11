import 'package:bloc/bloc.dart';
import 'package:easy_invoice/dataRequestModel/TownshipPart/EditTownship.dart';
import 'package:equatable/equatable.dart';

import '../../../data/responseModel/TownshipsPart/EditTownshipResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'edit_township_state.dart';

class EditTownshipCubit extends Cubit<EditTownshipState> {
  final UserRepository _userRepository;

  EditTownshipCubit(this._userRepository) : super(EditTownshipInitial());

  Future<void> updateTownship(int id, EditTownship editTownship) async {
    emit(EditTownshipLoading());
    try {
      final EditTownshipResponse response = await _userRepository.updateTownship(id, editTownship);
      emit(EditTownshipSuccess(response));
    } catch (error) {
      emit(EditTownshipFail(error.toString()));
    }
  }
}
