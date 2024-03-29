import 'package:easy_invoice/dataRequestModel/UserRequestModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/responseModel/UserResponse.dart';
import '../../data/userRepository/UserRepository.dart';

part 'add_user_role_state.dart';

class AddUserRoleCubit extends Cubit<AddUserRoleState> {
  final UserRepository _userRepository;
  AddUserRoleCubit(this._userRepository) : super(UserInitial());

  Future<void> addUser(UserRequestModel userRequestModel) async {
    emit(AddUserRoleLoading());
    try {
      final response = await _userRepository.user(userRequestModel);
      emit(AddUserRoleSuccess(response));
      //  print(emit(SignUpSuccess(response)));
    } catch (error) {
      emit(AddUserRoleFail(error.toString()));
    }
  }
}
