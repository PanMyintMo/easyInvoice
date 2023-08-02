part of 'edit_company_profile_cubit.dart';

abstract class EditCompanyProfileState extends Equatable {
  const EditCompanyProfileState();
}

class EditCompanyProfileInitial extends EditCompanyProfileState {
  @override
  List<Object> get props => [];
}

class EditCompanyProfileLoading extends EditCompanyProfileState {
  @override
  List<Object?> get props => [];
}

class EditCompanyProfileSuccess extends EditCompanyProfileState {
  final EditCompanyProfileResponse profileResponse;
  const EditCompanyProfileSuccess(this.profileResponse);
  @override
  List<Object?> get props => [profileResponse];
}

class EditCompanyProfileFail extends EditCompanyProfileState {
  final String error;
  const EditCompanyProfileFail(this.error);

  @override
  List<Object?> get props => [error];
}

