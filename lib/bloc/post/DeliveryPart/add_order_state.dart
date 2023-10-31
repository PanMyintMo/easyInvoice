part of 'add_order_cubit.dart';

abstract class AddOrderState extends Equatable {
  const AddOrderState();
}

class AddOrderInitial extends AddOrderState {
  @override
  List<Object> get props => [];
}
class AddOrderLoading extends AddOrderState {
  @override
  List<Object?> get props => [];
}


class ShopProductListLoading extends AddOrderState{
  @override
  List<Object?> get props => [];
}


class ShopProductListSuccess extends AddOrderState{
  final List<ShopProductItem> shopProductItem;
  const ShopProductListSuccess(this.shopProductItem);
  @override

  List<Object?> get props => [shopProductItem];

}

class ShopProductListFail extends AddOrderState{
  final String error;
  const ShopProductListFail(this.error);
  @override
  List<Object?> get props =>[error];
}


class AddOrderSuccess extends AddOrderState {
  final OrderResponse addOrderResponse;
  const AddOrderSuccess(this.addOrderResponse);
  @override
  List<Object?> get props => [addOrderResponse];
}

class AddOrderFail extends AddOrderState {
  final String error;
  const AddOrderFail(this.error);

  @override
  List<Object?> get props => [error];
}

