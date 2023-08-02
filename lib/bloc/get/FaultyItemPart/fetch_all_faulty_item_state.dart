part of 'fetch_all_faulty_item_cubit.dart';

abstract class FetchAllFaultyItemState extends Equatable {
  const FetchAllFaultyItemState();
}

class FetchAllFaultyItemInitial extends FetchAllFaultyItemState {
  @override
  List<Object> get props => [];
}
class FetchAllFaultyItemLoading extends FetchAllFaultyItemState{
  @override
  List<Object?> get props => [];
}

class FetchAllFaultyItemSuccess extends FetchAllFaultyItemState{
  final List<FaultyItemData> fetchAllFaultyItem;
  const FetchAllFaultyItemSuccess(this.fetchAllFaultyItem);
  @override

  List<Object?> get props => [fetchAllFaultyItem];

}

class FetchAllFaultyItemFail extends FetchAllFaultyItemState{
  final String error;
  const FetchAllFaultyItemFail(this.error);
  @override
  List<Object?> get props =>[error];
}

