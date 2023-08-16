part of 'warehouse_product_list_cubit.dart';

abstract class WarehouseProductListState extends Equatable {
  const WarehouseProductListState();
}

class WarehouseProductListInitial extends WarehouseProductListState {
  @override
  List<Object> get props => [];
}
class WarehouseProductListLoading extends WarehouseProductListState{
  @override
  List<Object?> get props => [];
}

class WarehouseProductListSuccess extends WarehouseProductListState{
  final List<WarehouseData> warehouseData;
  const WarehouseProductListSuccess(this.warehouseData);
  @override

  List<Object?> get props => [warehouseData];

}

class WarehouseProductListFail extends WarehouseProductListState{
  final String error;
  const WarehouseProductListFail(this.error);
  @override
  List<Object?> get props =>[error];
}

