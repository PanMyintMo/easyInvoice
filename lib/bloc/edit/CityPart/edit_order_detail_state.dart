part of 'edit_order_detail_cubit.dart';

abstract class EditOrderDetailState extends Equatable {
  const EditOrderDetailState();
}

class EditOrderDetailInitial extends EditOrderDetailState {
  @override
  List<Object> get props => [];
}
class EditOrderDetailLoading extends EditOrderDetailState {
  @override
  List<Object?> get props => [];
}
class EditOrderDetailSuccess extends EditOrderDetailState {
  final EditOrderData editOrderDetailResponse;
  const EditOrderDetailSuccess(this.editOrderDetailResponse);
  @override
  List<Object?> get props => [editOrderDetailResponse];
}

class EditOrderDetailFail extends EditOrderDetailState {
  final String error;
  const EditOrderDetailFail(this.error);

  @override
  List<Object?> get props => [error];
}
