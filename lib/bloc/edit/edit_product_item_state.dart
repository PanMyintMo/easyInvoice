part of 'edit_product_item_cubit.dart';

abstract class EditProductItemState extends Equatable {
  const EditProductItemState();
}

class EditProductItemInitial extends EditProductItemState {
  @override
  List<Object> get props => [];
}
class EditProductItemLoading extends EditProductItemState{
  @override
  List<Object?> get props => [];

}

class EditProductItemSuccess extends EditProductItemState{

 final EditProductResponse _editProductResponse;
  const EditProductItemSuccess(this._editProductResponse);

  @override
  List<Object?> get props => [_editProductResponse];

}
class EditProductItemFail extends EditProductItemState{
  final String error;
  const EditProductItemFail(this.error);
  @override
  List<Object?> get props => [error];

}