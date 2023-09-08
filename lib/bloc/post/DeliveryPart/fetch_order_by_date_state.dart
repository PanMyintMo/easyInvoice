part of 'fetch_order_by_date_cubit.dart';

abstract class FetchOrderByDateState extends Equatable {
  const FetchOrderByDateState();
}

class FetchOrderByDateInitial extends FetchOrderByDateState {
  @override
  List<Object> get props => [];
}
class FetchOrderByDateLoading extends FetchOrderByDateState{
  @override
  List<Object?> get props => [];
}

class FetchOrderByDateSuccess extends FetchOrderByDateState{
  final List<OrderFilterItem> fetchOrderByDate;
  const FetchOrderByDateSuccess(this.fetchOrderByDate);
  @override

  List<Object?> get props => [fetchOrderByDate];

}

class FetchOrderByDateFail extends FetchOrderByDateState{
  final String error;
  const FetchOrderByDateFail(this.error);
  @override
  List<Object?> get props =>[error];
}

