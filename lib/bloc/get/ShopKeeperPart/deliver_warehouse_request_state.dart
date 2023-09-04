part of 'deliver_warehouse_request_cubit.dart';

abstract class DeliverWarehouseRequestState extends Equatable {
  const DeliverWarehouseRequestState();
}

class DeliverWarehouseRequestInitial extends DeliverWarehouseRequestState {
  @override
  List<Object> get props => [];
}
class DeliverWarehouseRequestLoading extends DeliverWarehouseRequestState{
  @override
  List<Object?> get props => [];
}

class DeliverWarehouseRequestSuccess extends DeliverWarehouseRequestState{
  final List<DeliveryWarehouseItem> deliveryWarehouse;
  const DeliverWarehouseRequestSuccess(this.deliveryWarehouse);
  @override

  List<Object?> get props => [deliveryWarehouse];

}

class DeliverWarehouseRequestFail extends DeliverWarehouseRequestState{
  final String error;
  const DeliverWarehouseRequestFail(this.error);
  @override
  List<Object?> get props =>[error];
}
