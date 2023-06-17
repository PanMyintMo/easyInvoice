part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}
class UserLoading extends UserState {
  @override
  List<Object?> get props => [];
}

class UserSuccess extends UserState {
  final UserResponse userResponse;
  const UserSuccess(this.userResponse);
  @override
  List<Object?> get props => [userResponse];
}

class UserFailed extends UserState {
  final String error;
  const UserFailed(this.error);

  @override
  List<Object?> get props => [error];
}