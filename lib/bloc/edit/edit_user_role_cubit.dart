import 'package:bloc/bloc.dart';
import 'package:easy_invoice/data/responsemodel/EditUserRoleResponse.dart';
import 'package:easy_invoice/dataRequestModel/EditUserRoleRequestModel.dart';
import 'package:equatable/equatable.dart';
import '../../data/userRepository/UserRepository.dart';

part 'edit_user_role_state.dart';

class EditUserRoleCubit extends Cubit<EditUserRoleState> {
  final UserRepository _userRepository;
  EditUserRoleCubit(this._userRepository) : super(EditUserRoleInitial());

  Future<void> editUserRole(EditUserRoleRequestModel editCategory, int id) async {
    emit(EditUserRoleLoading());
    try {
      final respone = await _userRepository.editUserRole(editCategory, id);
      emit(EditUserRoleSuccess(respone));
    }
    catch (error) {
      emit(EditUserRoleFail(error.toString()));
    }
  }
}
