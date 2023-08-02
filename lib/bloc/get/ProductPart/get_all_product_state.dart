part of 'get_all_product_cubit.dart';

abstract class GetAllProductState extends Equatable {
  const GetAllProductState();
}

class GetAllProductInitial extends GetAllProductState {
  @override
  List<Object> get props => [];
}

class GetAllProductLoading extends GetAllProductState{
  @override
  List<Object?> get props => [];
}

class GetAllProductSuccess extends GetAllProductState{
  final List<ProductListItem> products;
  const GetAllProductSuccess(this.products);
  @override

  List<Object?> get props => [products];

}

class GetAllProductFail extends GetAllProductState{
  final String error;
  const GetAllProductFail(this.error);
  @override
  List<Object?> get props =>[error];
}
