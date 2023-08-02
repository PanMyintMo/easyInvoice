part of 'fetch_all_warehouse_request_cubit.dart';

abstract class FetchAllWarehouseRequestState extends Equatable {
  const FetchAllWarehouseRequestState();
}

class FetchAllWarehouseRequestInitial extends FetchAllWarehouseRequestState {
  @override
  List<Object> get props => [];
}
class FetchAllWarehouseRequestLoading extends FetchAllWarehouseRequestState{
  @override
  List<Object?> get props => [];
}

class FetchAllWarehouseRequestSuccess extends FetchAllWarehouseRequestState{
  final List<DeliveryItemData> deliveryItemData;
  const FetchAllWarehouseRequestSuccess(this.deliveryItemData);
  @override

  List<Object?> get props => [deliveryItemData];

}

class FetchAllWarehouseRequestFail extends FetchAllWarehouseRequestState{
  final String error;
  const FetchAllWarehouseRequestFail(this.error);
  @override
  List<Object?> get props =>[error];
}
