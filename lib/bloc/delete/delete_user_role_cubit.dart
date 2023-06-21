import 'package:bloc/bloc.dart';
import 'package:easy_invoice/data/responsemodel/DeleteUserRoleResponse.dart';
import 'package:equatable/equatable.dart';

import '../../data/userRepository/UserRepository.dart';

part 'delete_user_role_state.dart';

class DeleteUserRoleCubit extends Cubit<DeleteUserRoleState> {
  final UserRepository _userRepository;
  DeleteUserRoleCubit(this._userRepository) : super(DeleteUserRoleInitial());
  Future<void> deleteUserRole(int id) async{
    emit(DeleteUserRoleLoading());

    try{
      final response= await _userRepository.deleteUserRole(id);
      emit(DeleteUserRoleSuccess(response));
    }
    catch(error){
      emit(DeleteUserRoleFail(error.toString()));
    }
  }
}
