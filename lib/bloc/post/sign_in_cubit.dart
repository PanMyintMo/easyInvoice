import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_invoice/data/model/loginResponse/LoginResponse.dart';
import 'package:easy_invoice/dataModel/LoginRequestModel.dart';
import 'package:equatable/equatable.dart';
import '../../data/userRepository/UserRepository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final UserRepository _userRepository;

  SignInCubit(this._userRepository) : super(SignInInitial());

  void signIn(LoginRequestModel loginRequestModel) {
    emit(SignInInitial());
    // Start the timer
    Timer(const Duration(seconds: 3), () {
      // Simulate the loading process
      _userRepository.signin(loginRequestModel).then((value) {
        emit(SignInSuccess(value));
      }).catchError((error) {
        if (error is DioError) {
          final errorMessage = error.message;
          emit(SignInFail(errorMessage!));
        } else {
          emit(SignInFail('Sign in fail'));
        }
      });
    });

    // Show the loading state immediately
    emit(SignInLoading());
  }
}

