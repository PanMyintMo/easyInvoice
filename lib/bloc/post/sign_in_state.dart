part of 'sign_in_cubit.dart';

abstract class SignInState extends Equatable {
  const SignInState();
}

class SignInInitial extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInLoading extends SignInState {
  @override
  List<Object?> get props => [];
}

class SignInSuccess extends SignInState {
  final LoginResponse loginResponse;
  const SignInSuccess(this.loginResponse);
  @override
  List<Object?> get props => [loginResponse];
}

class SignInFail extends SignInState {
  final String error;
  const SignInFail(this.error);

  @override
  List<Object?> get props => [error];
}

