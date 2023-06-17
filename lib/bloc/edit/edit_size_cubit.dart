import 'package:bloc/bloc.dart';
import 'package:easy_invoice/data/responsemodel/UpdateSizeResponse.dart';
import 'package:equatable/equatable.dart';

import '../../data/userRepository/UserRepository.dart';
import '../../dataRequestModel/EditSizeModel.dart';

part 'edit_size_state.dart';

class EditSizeCubit extends Cubit<EditSizeState> {

  final UserRepository _userRepository;
  EditSizeCubit(this._userRepository) : super(EditSizeInitial());

  Future<void> editSize(EditSize editSize, int id) async {
    emit(EditSizeLoading());
    try {
      final respone = await _userRepository.updateSize(editSize, id);
      emit(EditSizeSuccess(respone));
    }
    catch (error) {
      emit(EditSizeFail(error.toString()));
    }
  }


}
