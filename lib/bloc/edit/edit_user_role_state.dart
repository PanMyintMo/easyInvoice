part of 'edit_user_role_cubit.dart';

abstract class EditUserRoleState extends Equatable {
  const EditUserRoleState();
}

class EditUserRoleInitial extends EditUserRoleState {
  @override
  List<Object> get props => [];
}
class EditUserRoleLoading extends EditUserRoleState{
  @override
  List<Object?> get props => [];

}

class EditUserRoleSuccess extends EditUserRoleState{

  final EditUserRoleResponse editUserRoleResponse;

  const EditUserRoleSuccess(this.editUserRoleResponse);
  @override
  List<Object?> get props => [editUserRoleResponse];

}
class EditUserRoleFail extends EditUserRoleState{
  final String error;
  const EditUserRoleFail(this.error);
  @override
  List<Object?> get props => [error];

}