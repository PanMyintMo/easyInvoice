part of 'shop_product_list_cubit.dart';

abstract class ShopProductListState extends Equatable {
  const ShopProductListState();
}

class ShopProductListInitial extends ShopProductListState {
  @override
  List<Object> get props => [];
}

class ShopProductListLoading extends ShopProductListState{
  @override
  List<Object?> get props => [];
}

class ShopProductListSuccess extends ShopProductListState{
  final List<ShopProductItem> shopProductItem;
  const ShopProductListSuccess(this.shopProductItem);
  @override

  List<Object?> get props => [shopProductItem];

}

class ShopProductListFail extends ShopProductListState{
  final String error;
  const ShopProductListFail(this.error);
  @override
  List<Object?> get props =>[error];
}
