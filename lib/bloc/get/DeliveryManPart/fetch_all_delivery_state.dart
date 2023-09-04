part of 'fetch_all_delivery_cubit.dart';

abstract class FetchAllDeliveryState extends Equatable {
  const FetchAllDeliveryState();
}

class FetchAllDeliveryInitial extends FetchAllDeliveryState {
  @override
  List<Object> get props => [];
}
class FetchAllDeliveryLoading extends FetchAllDeliveryState{
  @override
  List<Object?> get props => [];
}

class FetchAllDeliverySuccess extends FetchAllDeliveryState{
  final List<DeliveriesItem> deliveryItemData;
  const FetchAllDeliverySuccess(this.deliveryItemData);
  @override

  List<Object?> get props => [deliveryItemData];

}

class FetchAllDeliveryFail extends FetchAllDeliveryState{
  final String error;
  const FetchAllDeliveryFail(this.error);
  @override
  List<Object?> get props =>[error];
}
