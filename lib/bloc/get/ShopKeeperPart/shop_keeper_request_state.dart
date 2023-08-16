part of 'shop_keeper_request_cubit.dart';

abstract class ShopKeeperRequestState extends Equatable {
  const ShopKeeperRequestState();
}

class ShopKeeperRequestInitial extends ShopKeeperRequestState {
  @override
  List<Object> get props => [];
}
class ShopKeeperRequestLoading extends ShopKeeperRequestState{
  @override
  List<Object?> get props => [];
}

class ShopKeeperRequestSuccess extends ShopKeeperRequestState{
  final List<ShopRequestData> shopRequestData;
  const ShopKeeperRequestSuccess(this.shopRequestData);
  @override

  List<Object?> get props => [shopRequestData];

}

class ShopKeeperRequestFail extends ShopKeeperRequestState{
  final String error;
  const ShopKeeperRequestFail(this.error);
  @override
  List<Object?> get props =>[error];
}
