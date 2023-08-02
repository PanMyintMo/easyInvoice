part of 'add_request_faulty_item_cubit.dart';

abstract class AddRequestFaultyItemState extends Equatable {
  const AddRequestFaultyItemState();
}

class AddRequestFaultyItemInitial extends AddRequestFaultyItemState {
  @override
  List<Object> get props => [];
}
class AddRequestFaultyItemLoading extends AddRequestFaultyItemState {
  @override
  List<Object?> get props => [];
}

class AddRequestFaultyItemSuccess extends AddRequestFaultyItemState {
  final AddFaultyItemResponse addFaultyItemResponse;
  const AddRequestFaultyItemSuccess(this.addFaultyItemResponse);
  @override
  List<Object?> get props => [addFaultyItemResponse];
}

class AddRequestFaultyItemFail extends AddRequestFaultyItemState {
  final String error;
  const AddRequestFaultyItemFail(this.error);

  @override
  List<Object?> get props => [error];
}

