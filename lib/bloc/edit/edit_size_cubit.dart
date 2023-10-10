import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/responsemodel/common/UpdateResponse.dart';
import '../../data/userRepository/UserRepository.dart';
import '../../dataRequestModel/EditSizeModel.dart';

part 'edit_size_state.dart';

class EditSizeCubit extends Cubit<EditSizeState> {

  final UserRepository _userRepository;
  EditSizeCubit(this._userRepository) : super(EditSizeInitial());

  Future<void> editSize(EditSize editSize, int id) async {
    emit(EditSizeLoading());
    try {
      final response = await _userRepository.updateSize(editSize, id);
      emit(EditSizeSuccess(response));
    }
    catch (error) {
      emit(EditSizeFail(error.toString()));
    }
  }


}
