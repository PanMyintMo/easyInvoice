import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_invoice/data/model/registerResponse/RegisterResponse.dart';
import 'package:easy_invoice/dataModel/RegisterRequestModel.dart';
import 'package:equatable/equatable.dart';
import '../../data/userRepository/UserRepository.dart';

part 'sign_up_state.dart';
class SignUpCubit extends Cubit<SignUpState> {
  final UserRepository _userRepository;

  SignUpCubit(this._userRepository) : super(SignUpInitial());

  void signUp(RegisterRequestModel registerRequestModel) {
    emit(SignUpInitial());

    _userRepository.singnup(registerRequestModel)
        .then((value) => emit(SignUpSuccess(value)))
        .catchError((error) {
      if (error is DioError) {
        final errorMessage = error.message;
        emit(SignUpFail(errorMessage!));
      } else {
        emit(SignUpFail('Sign up fail'));
      }
    });
  }
}