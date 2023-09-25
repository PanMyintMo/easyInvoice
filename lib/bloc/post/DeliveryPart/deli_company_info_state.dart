part of 'deli_company_info_cubit.dart';

abstract class DeliCompanyInfoState extends Equatable {
  const DeliCompanyInfoState();
}

class DeliCompanyInfoInitial extends DeliCompanyInfoState {
  @override
  List<Object> get props => [];
}
class DeliCompanyInfoLoading extends DeliCompanyInfoState {
  @override
  List<Object?> get props => [];
}

class DeliCompanyInfoSuccess extends DeliCompanyInfoState {
  final DeliCompanyInfoResponse deliCompanyResponse;
  const DeliCompanyInfoSuccess(this.deliCompanyResponse);
  @override
  List<Object?> get props => [deliCompanyResponse];
}

class DeliCompanyInfoFail extends DeliCompanyInfoState {
  final String error;
  const DeliCompanyInfoFail(this.error);

  @override
  List<Object?> get props => [error];
}
