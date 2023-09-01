part of 'delete_shop_keeper_product_request_cubit.dart';

abstract class DeleteShopKeeperProductRequestState extends Equatable {
  const DeleteShopKeeperProductRequestState();
}

class DeleteShopKeeperProductRequestInitial extends DeleteShopKeeperProductRequestState {
  @override
  List<Object> get props => [];
}

class DeleteShopKeeperProductRequestLoading extends DeleteShopKeeperProductRequestState {
  @override
  List<Object?> get props => [];
}

class DeleteShopKeeperProductRequestSuccess extends DeleteShopKeeperProductRequestState {
  final DeleteResponse deleteResponse;

  const DeleteShopKeeperProductRequestSuccess(this.deleteResponse);

  @override
  List<Object?> get props => [deleteResponse];
}

class DeleteShopKeeperProductRequestItemFail extends DeleteShopKeeperProductRequestState {
  final String error;

  const DeleteShopKeeperProductRequestItemFail(this.error);

  @override
  List<Object?> get props => [error];
}
