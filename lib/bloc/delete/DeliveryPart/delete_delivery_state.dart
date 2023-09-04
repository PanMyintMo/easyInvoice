part of 'delete_delivery_cubit.dart';

abstract class DeleteDeliveryState extends Equatable {
  const DeleteDeliveryState();
}

class DeleteDeliveryInitial extends DeleteDeliveryState {
  @override
  List<Object> get props => [];
}
class DeleteDeliveryLoading extends DeleteDeliveryState {
  @override
  List<Object?> get props => [];
}

class DeleteDeliverySuccess extends DeleteDeliveryState {
  final DeleteResponse deleteResponse;

  const DeleteDeliverySuccess(this.deleteResponse);

  @override
  List<Object?> get props => [deleteResponse];
}

class DeleteDeliveryFail extends DeleteDeliveryState {
  final String error;

  const DeleteDeliveryFail(this.error);

  @override
  List<Object?> get props => [error];
}
