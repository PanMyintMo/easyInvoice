part of 'update_delivery_cubit.dart';

abstract class UpdateDeliveryState extends Equatable {
  const UpdateDeliveryState();
}

class UpdateDeliveryInitial extends UpdateDeliveryState {
  @override
  List<Object> get props => [];
}
class UpdateDeliveryLoading extends UpdateDeliveryState{
  @override
  List<Object?> get props => [];
}

class UpdateDeliverySuccess extends UpdateDeliveryState{
  final DeliCompanyInfoResponse updateDelivery;
  const UpdateDeliverySuccess(this.updateDelivery);
  @override

  List<Object?> get props => [updateDelivery];

}

class UpdateDeliveryFail extends UpdateDeliveryState{
  final String error;
  const UpdateDeliveryFail(this.error);
  @override
  List<Object?> get props =>[error];
}

