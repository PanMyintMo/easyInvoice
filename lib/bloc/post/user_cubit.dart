import 'package:bloc/bloc.dart';
import 'package:easy_invoice/data/responsemodel/UserResponse.dart';
import 'package:easy_invoice/dataRequestModel/UserRequestModel.dart';
import 'package:equatable/equatable.dart';
import '../../data/userRepository/UserRepository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;
  UserCubit(this._userRepository) : super(UserInitial());

  Future<void> addUser(UserRequestModel userRequestModel) async {
    emit(UserLoading());
    try {
      final response = await _userRepository.user(userRequestModel);
      emit(UserSuccess(response));
      //  print(emit(SignUpSuccess(response)));
    } catch (error) {
      emit(UserFailed(error.toString()));
    }
  }
}
