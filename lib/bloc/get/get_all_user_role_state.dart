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
  final UserRoleResponse getAllUserRoleResponse;
  const GetAllUserRoleSuccess(this.getAllUserRoleResponse);
  @override

  List<Object?> get props => [getAllUserRoleResponse];

}

class GetAllUserRoleFail extends GetAllUserRoleState{
  final String error;
  const GetAllUserRoleFail(this.error);
  @override
  List<Object?> get props =>[error];
}

