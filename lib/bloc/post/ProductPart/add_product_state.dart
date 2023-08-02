part of 'add_product_cubit.dart';

abstract class AddProductState extends Equatable {
  const AddProductState();
}

class AddProductInitial extends AddProductState {
  @override
  List<Object> get props => [];
}



class AddProductLoading extends AddProductState {
  @override
  List<Object?> get props => [];
}

class AddProductSuccess extends AddProductState {
  final ProductResponse addProductResponse;

  const AddProductSuccess(this.addProductResponse);

  @override
  List<Object?> get props => [addProductResponse];
}

class AddProductFail extends AddProductState {
  final String error;

  const AddProductFail(this.error);

  @override
  List<Object?> get props => [error];

}

