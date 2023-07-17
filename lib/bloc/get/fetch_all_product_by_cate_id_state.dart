/*
part of 'fetch_all_product_by_cate_id_cubit.dart';

abstract class FetchAllProductByCateIdState extends Equatable {
  const FetchAllProductByCateIdState();
}

class FetchAllProductByCateIdInitial extends FetchAllProductByCateIdState {
  @override
  List<Object> get props => [];
}

class GetAllProductByCateIdLoading extends FetchAllProductByCateIdState{
  @override
  List<Object?> get props => [];
}

class GetAllProductByCateIdSuccess extends FetchAllProductByCateIdState{
  final List<ProductItem> productsByCateId;
  const GetAllProductByCateIdSuccess(this.productsByCateId);
  @override

  List<Object?> get props => [productsByCateId];

}

class GetAllProductByCateIdFail extends FetchAllProductByCateIdState{
  final String error;
  const GetAllProductByCateIdFail(this.error);
  @override
  List<Object?> get props =>[error];
}*/
