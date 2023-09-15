part of 'shopkeeper_status_cubit.dart';

abstract class ShopkeeperStatusState extends Equatable {
  const ShopkeeperStatusState();
}

class ShopkeeperStatusInitial extends ShopkeeperStatusState {
  @override
  List<Object> get props => [];
}
class ShopkeeperStatusLoading extends ShopkeeperStatusState {
  @override
  List<Object?> get props => [];
}

class ShopkeeperStatusSuccess extends ShopkeeperStatusState {
  final DeleteResponse shopkeeperStatus;

  const ShopkeeperStatusSuccess(this.shopkeeperStatus);

  @override
  List<Object?> get props => [shopkeeperStatus];
}

class ShopkeeperStatusFail extends ShopkeeperStatusState {
  final String error;

  const ShopkeeperStatusFail(this.error);

  @override
  List<Object?> get props => [error];
}

