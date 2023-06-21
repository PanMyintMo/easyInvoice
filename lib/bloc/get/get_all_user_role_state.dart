part of 'get_all_user_role_cubit.dart';

abstract class GetAllUserRoleState extends Equatable {
  const GetAllUserRoleState();
}

class GetAllUserRoleInitial extends GetAllUserRoleState {
  @override
  List<Object> get props => [];
}

class GetAllUserRoleLoading extends GetAllUserRoleState{
  @override
  List<Object?> get props => [];
}

class GetAllUserRoleSuccess extends GetAllUserRoleState{
  final UserRoleResponse getAllUserRole;
  const GetAllUserRoleSuccess(this.getAllUserRole);
  @override

  List<Object?> get props => [getAllUserRole];

}

class GetAllUserRoleFail extends GetAllUserRoleState{
  final String error;
  const GetAllUserRoleFail(this.error);
  @override
  List<Object?> get props =>[error];
}

