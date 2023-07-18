part of 'add_delivery_cubit.dart';

abstract class AddDeliveryState extends Equatable {
  const AddDeliveryState();
}

class AddDeliveryInitial extends AddDeliveryState {
  @override
  List<Object> get props => [];
}

class AddDeliveryLoading extends AddDeliveryState {
  @override
  List<Object?> get props => [];
}

class AddDeliverySuccess extends AddDeliveryState {
  final AddDeliveryResponse addDeliveryResponse;
  const AddDeliverySuccess(this.addDeliveryResponse);
  @override
  List<Object?> get props => [addDeliveryResponse];
}

class AddDeliveryFail extends AddDeliveryState {
  final String error;
  const AddDeliveryFail(this.error);

  @override
  List<Object?> get props => [error];
}

