part of 'delivery_man_status_cubit.dart';

abstract class DeliveryManStatusState extends Equatable {
  const DeliveryManStatusState();
}

class DeliveryManStatusInitial extends DeliveryManStatusState {
  @override
  List<Object> get props => [];
}
class DeliveryManStatusLoading extends DeliveryManStatusState {
  @override
  List<Object?> get props => [];
}

class DeliveryManStatusSuccess extends DeliveryManStatusState {
  final DeleteResponse deliveryStatus;

  const DeliveryManStatusSuccess(this.deliveryStatus);

  @override
  List<Object?> get props => [deliveryStatus];
}

class DeliveryManStatusFail extends DeliveryManStatusState {
  final String error;

  const DeliveryManStatusFail(this.error);

  @override
  List<Object?> get props => [error];
}

