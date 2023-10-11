import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/responseModel/GeneralMainResponse/LoginResponse.dart';
import '../../../data/userRepository/UserRepository.dart';
import '../../../dataRequestModel/Login&Register/LoginRequestModel.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final UserRepository _userRepository;

  SignInCubit(this._userRepository) : super(SignInInitial());

  Future<void> signIn(LoginRequestModel loginRequestModel) async {
    emit(SignInLoading());
    try {
      final response = await _userRepository.signIn(loginRequestModel);
      emit(SignInSuccess(response));
      //  print(emit(SignUpSuccess(response)));
    } catch (error) {
      emit(SignInFail(error.toString()));
    }
  }
}
