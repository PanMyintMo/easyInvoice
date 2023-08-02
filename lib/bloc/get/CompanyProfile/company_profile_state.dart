part of 'company_profile_cubit.dart';

abstract class CompanyProfileState extends Equatable {
  const CompanyProfileState();
}

class CompanyProfileInitial extends CompanyProfileState {
  @override
  List<Object> get props => [];
}
class CompanyProfileLoading extends CompanyProfileState{
  @override
  List<Object?> get props => [];
}

class CompanyProfileSuccess extends CompanyProfileState{
  final CompanyProfileData companyProfileData;
  const CompanyProfileSuccess(this.companyProfileData);
  @override

  List<Object?> get props => [companyProfileData];

}

class CompanyProfileFail extends CompanyProfileState{
  final String error;
  const CompanyProfileFail(this.error);
  @override
  List<Object?> get props =>[error];
}
