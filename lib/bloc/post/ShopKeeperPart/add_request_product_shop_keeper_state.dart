part of 'add_request_product_shop_keeper_cubit.dart';

abstract class AddRequestProductShopKeeperState extends Equatable {
  const AddRequestProductShopKeeperState();
}

class AddRequestProductShopKeeperInitial extends AddRequestProductShopKeeperState {
  @override
  List<Object> get props => [];
}

class AddRequestProductShopKeeperLoading extends AddRequestProductShopKeeperState {
  @override
  List<Object?> get props => [];
}

class AddRequestProductShopKeeperSuccess extends AddRequestProductShopKeeperState {
  final AddShopKeeperResponse addShopKeeperResponse;

  const AddRequestProductShopKeeperSuccess(this.addShopKeeperResponse);

  @override
  List<Object?> get props => [addShopKeeperResponse];
}

class AddRequestProductShopKeeperFail extends AddRequestProductShopKeeperState {
  final String error;

  const AddRequestProductShopKeeperFail(this.error);

  @override
  List<Object?> get props => [error];

}