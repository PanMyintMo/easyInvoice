part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpLoading extends SignUpState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SignUpSuccess extends SignUpState{
  final RegisterResponse registerResponse;

  const SignUpSuccess(this.registerResponse);
  @override
  // TODO: implement props
  List<Object?> get props => [registerResponse];

}

class SignUpFail extends SignUpState {
  final String error;

  const SignUpFail(this.error);

  @override
  List<Object?> get props => [error];
}

