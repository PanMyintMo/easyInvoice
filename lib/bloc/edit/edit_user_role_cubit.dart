import 'package:easy_invoice/dataRequestModel/EditUserRoleRequestModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/responseModel/EditUserRoleResponse.dart';
import '../../data/userRepository/UserRepository.dart';

part 'edit_user_role_state.dart';

class EditUserRoleCubit extends Cubit<EditUserRoleState> {
  final UserRepository _userRepository;
  EditUserRoleCubit(this._userRepository) : super(EditUserRoleInitial());

  Future<void> editUserRole(EditUserRoleRequestModel editUserRoleRequestModel, int id) async {
    emit(EditUserRoleLoading());
    try {
      final response = await _userRepository.editUserRole(editUserRoleRequestModel, id);
      emit(EditUserRoleSuccess(response));
    }
    catch (error) {
      emit(EditUserRoleFail(error.toString()));
    }
  }
}
