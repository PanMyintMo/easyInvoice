import 'package:bloc/bloc.dart';
import 'package:easy_invoice/dataModel/LoginRequestModel.dart';
import 'package:equatable/equatable.dart';
import '../../data/responsemodel/loginResponse/LoginResponse.dart';
import '../../data/userRepository/UserRepository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final UserRepository _userRepository;

  SignInCubit(this._userRepository) : super(SignInInitial());

  Future<void> signIn(LoginRequestModel loginRequestModel) async {
    emit(SignInInitial());

  /*  try {
      final LoginRequestModel response =
      (await _userRepository.signin(loginRequestModel)) as LoginRequestModel;
      if (response != null) {
        emit(SignInSuccess(response as LoginResponse));
      } else {
        emit(SignInFail('Sign up failed'));
      }
    } catch (error) {
      if (error is DioError) {
        final errorMessage = error.message;
        emit(SignInFail(errorMessage!));
      } else {
        emit(SignInFail('Sign up failed'));
      }
    }*/
  }
}
