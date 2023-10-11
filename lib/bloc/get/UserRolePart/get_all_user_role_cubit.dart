import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/responseModel/UserRoleResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'get_all_user_role_state.dart';

class GetAllUserRoleCubit extends Cubit<GetAllUserRoleState> {
  final UserRepository _userRepository;
  GetAllUserRoleCubit(this._userRepository) : super(GetAllUserRoleInitial());

  Future<void> getAllUserRole() async {
    emit(GetAllUserRoleLoading());
    try {
      final  response = await _userRepository.getAllUserRole();

      final List<UserData> userData= response.data;

      emit(GetAllUserRoleSuccess(userData));
    } catch (error) {
      emit(GetAllUserRoleFail(error.toString()));
    }
  }
}
