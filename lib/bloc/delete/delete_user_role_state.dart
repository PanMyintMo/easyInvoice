part of 'delete_user_role_cubit.dart';

abstract class DeleteUserRoleState extends Equatable {
  const DeleteUserRoleState();
}

class DeleteUserRoleInitial extends DeleteUserRoleState {
  @override
  List<Object> get props => [];
}

class DeleteUserRoleLoading extends DeleteUserRoleState {
  @override
  List<Object?> get props => [];
}

class DeleteUserRoleSuccess extends DeleteUserRoleState {
  final DeleteUserRoleResponse deleteUserRoleResponse;

  const DeleteUserRoleSuccess(this.deleteUserRoleResponse);

  @override
  List<Object?> get props => [deleteUserRoleResponse];
}

class DeleteUserRoleFail extends DeleteUserRoleState {
  final String error;

  const DeleteUserRoleFail(this.error);

  @override
  List<Object?> get props => [error];
}



