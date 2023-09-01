part of 'delete_product_item_cubit.dart';

abstract class DeleteProductItemState extends Equatable {
  const DeleteProductItemState();
}

class DeleteProductItemInitial extends DeleteProductItemState {
  @override
  List<Object> get props => [];
}

class DeleteProductItemLoading extends DeleteProductItemState {
  @override
  List<Object?> get props => [];
}

class DeleteProductItemSuccess extends DeleteProductItemState {
  final DeleteResponse deleteResponse;

  const DeleteProductItemSuccess(this.deleteResponse);

  @override
  List<Object?> get props => [deleteResponse];
}

class DeleteProductItemFail extends DeleteProductItemState {
  final String error;

  const DeleteProductItemFail(this.error);

  @override
  List<Object?> get props => [error];
}
