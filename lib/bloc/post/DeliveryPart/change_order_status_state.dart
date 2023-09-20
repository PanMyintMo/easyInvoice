part of 'change_order_status_cubit.dart';

abstract class ChangeOrderStatusState extends Equatable {
  const ChangeOrderStatusState();
}

class ChangeOrderStatusInitial extends ChangeOrderStatusState {
  @override
  List<Object> get props => [];
}
class ChangeOrderStatusLoading extends ChangeOrderStatusState {
  @override
  List<Object?> get props => [];
}

class ChangeOrderStatusSuccess extends ChangeOrderStatusState {
  final DeleteResponse orderStatusResponse;
  const ChangeOrderStatusSuccess(this.orderStatusResponse);
  @override
  List<Object?> get props => [orderStatusResponse];
}

class ChangeOrderStatusFail extends ChangeOrderStatusState {
  final String error;
  const ChangeOrderStatusFail(this.error);

  @override
  List<Object?> get props => [error];
}

