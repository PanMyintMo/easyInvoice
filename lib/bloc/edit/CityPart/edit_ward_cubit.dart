import 'package:bloc/bloc.dart';
import 'package:easy_invoice/data/responsemodel/CityPart/EditWardResponse.dart';
import 'package:equatable/equatable.dart';

import '../../../data/userRepository/UserRepository.dart';
import '../../../dataRequestModel/CityPart/AddWardRequestModel.dart';

part 'edit_ward_state.dart';

class EditWardCubit extends Cubit<EditWardState> {
  final UserRepository _userRepository;

  EditWardCubit(this._userRepository) : super(EditWardInitial());

  Future<void> updateWard(int id, AddWardRequestModel editWard) async {
    emit(EditWardLoading());
    try {
      final EditWardResponse response = await _userRepository.updateWard(id, editWard);
      emit(EditWardSuccess(response));
    } catch (error) {
      emit(EditWardFail(error.toString()));
    }
  }
}
