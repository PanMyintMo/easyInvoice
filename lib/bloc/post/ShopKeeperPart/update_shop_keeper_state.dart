part of 'update_shop_keeper_cubit.dart';

abstract class UpdateShopKeeperState extends Equatable {
  const UpdateShopKeeperState();
}

class UpdateShopKeeperInitial extends UpdateShopKeeperState {
  @override
  List<Object> get props => [];
}

class  UpdateShopKeeperLoading extends UpdateShopKeeperState {
  @override
  List<Object?> get props => [];
}

class  UpdateShopKeeperSuccess extends UpdateShopKeeperState {
  final EditResponse updateShopkeeper;

  const UpdateShopKeeperSuccess(this.updateShopkeeper);

  @override
  List<Object?> get props => [updateShopkeeper];
}

class  UpdateShopKeeperFail extends UpdateShopKeeperState {
  final String error;

  const UpdateShopKeeperFail(this.error);

  @override
  List<Object?> get props => [error];

}