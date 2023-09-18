part of 'fetch_all_order_detail_cubit.dart';

abstract class FetchAllOrderDetailState extends Equatable {
  const FetchAllOrderDetailState();
}

class FetchAllOrderDetailInitial extends FetchAllOrderDetailState {
  @override
  List<Object> get props => [];
}
class FetchAllOrderDetailLoading extends FetchAllOrderDetailState{
  @override
  List<Object?> get props => [];
}

class FetchAllOrderDetailSuccess extends FetchAllOrderDetailState{
  final OrderDetailResponse orderDetail;
  const FetchAllOrderDetailSuccess(this.orderDetail);
  @override

  List<Object?> get props => [orderDetail];

}

class FetchAllOrderDetailFail extends FetchAllOrderDetailState{
  final String error;
  const FetchAllOrderDetailFail(this.error);
  @override
  List<Object?> get props =>[error];
}
