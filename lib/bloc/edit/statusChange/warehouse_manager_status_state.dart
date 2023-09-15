part of 'warehouse_manager_status_cubit.dart';

abstract class WarehouseManagerStatusState extends Equatable {
  const WarehouseManagerStatusState();
}

class WarehouseManagerStatusInitial extends WarehouseManagerStatusState {
  @override
  List<Object> get props => [];
}
class WarehouseManagerStatusLoading extends WarehouseManagerStatusState {
  @override
  List<Object?> get props => [];
}

class WarehouseManagerStatusSuccess extends WarehouseManagerStatusState {
  final DeleteResponse deleteSizeResponse;

  const WarehouseManagerStatusSuccess(this.deleteSizeResponse);

  @override
  List<Object?> get props => [deleteSizeResponse];
}

class WarehouseManagerStatusFail extends WarehouseManagerStatusState {
  final String error;

  const WarehouseManagerStatusFail(this.error);

  @override
  List<Object?> get props => [error];
}



