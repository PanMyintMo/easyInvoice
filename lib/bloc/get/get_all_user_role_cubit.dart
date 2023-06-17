import 'package:bloc/bloc.dart';
import 'package:easy_invoice/data/responsemodel/UserRoleResponse.dart';
import 'package:equatable/equatable.dart';

import '../../data/userRepository/UserRepository.dart';

part 'get_all_user_role_state.dart';

class GetAllUserRoleCubit extends Cubit<GetAllUserRoleState> {
  final UserRepository _userRepository;
  GetAllUserRoleCubit(this._userRepository) : super(GetAllUserRoleInitial());

  Future<void> getAllUserRole() async {
    emit(GetAllUserRoleLoading());
    try {
      final UserRoleResponse response = await _userRepository.getAllUserRole();
      emit(GetAllUserRoleSuccess(response));
    } catch (error) {
      emit(GetAllUserRoleFail(error.toString()));
    }
  }


}
