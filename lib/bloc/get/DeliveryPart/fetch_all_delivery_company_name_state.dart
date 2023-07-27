/*
part of 'fetch_all_delivery_company_name_cubit.dart';

abstract class FetchAllDeliveryCompanyNameState extends Equatable {
  const FetchAllDeliveryCompanyNameState();
}

class FetchAllDeliveryCompanyNameInitial extends FetchAllDeliveryCompanyNameState {
  @override
  List<Object> get props => [];
}

class FetchAllDeliveryCompanyNameLoading extends FetchAllDeliveryCompanyNameState{
  @override
  List<Object?> get props => [];
}

class FetchAllDeliveryCompanyNameSuccess extends FetchAllDeliveryCompanyNameState{
  final List<AllDeliveryName> allDeliveryCompanyName;
  const FetchAllDeliveryCompanyNameSuccess(this.allDeliveryCompanyName);
  @override

  List<Object?> get props => [allDeliveryCompanyName];

}

class FetchAllDeliveryCompanyNameFail extends FetchAllDeliveryCompanyNameState{
  final String error;
  const FetchAllDeliveryCompanyNameFail(this.error);
  @override
  List<Object?> get props =>[error];
}
*/
