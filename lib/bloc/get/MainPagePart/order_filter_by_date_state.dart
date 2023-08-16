part of 'order_filter_by_date_cubit.dart';

abstract class OrderFilterByDateState extends Equatable {
  const OrderFilterByDateState();
}

class OrderFilterByDateInitial extends OrderFilterByDateState {
  @override
  List<Object> get props => [];
}
class OrderFilterByDateLoading extends OrderFilterByDateState{
  @override
  List<Object?> get props => [];
}

class OrderFilterByDateSuccess extends OrderFilterByDateState {
  final OrderApiResponse selectedResponse; // Add this line

  const OrderFilterByDateSuccess({
    required this.selectedResponse, // Update the constructor parameter
  });

  @override
  List<Object?> get props => [
    selectedResponse, // Update the props list
  ];
}



class OrderFilterByDateFail extends OrderFilterByDateState{
  final String error;
  const OrderFilterByDateFail(this.error);
  @override
  List<Object?> get props =>[error];
}
