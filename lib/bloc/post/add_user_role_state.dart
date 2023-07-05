part of 'add_user_role_cubit.dart';

abstract class AddUserRoleState extends Equatable {
  const AddUserRoleState();
}

class UserInitial extends AddUserRoleState {
  @override
  List<Object> get props => [];
}
class AddUserRoleLoading extends AddUserRoleState {
  @override
  List<Object?> get props => [];
}

class AddUserRoleSuccess extends AddUserRoleState {
  final UserResponse userResponse;
  const AddUserRoleSuccess(this.userResponse);
  @override
  List<Object?> get props => [userResponse];
}

class AddUserRoleFail extends AddUserRoleState {
  final String error;
  const AddUserRoleFail(this.error);

  @override
  List<Object?> get props => [error];
}