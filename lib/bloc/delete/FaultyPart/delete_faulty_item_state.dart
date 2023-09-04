part of 'delete_faulty_item_cubit.dart';

abstract class DeleteFaultyItemState extends Equatable {
  const DeleteFaultyItemState();
}

class DeleteFaultyItemInitial extends DeleteFaultyItemState {
  @override
  List<Object> get props => [];
}
class DeleteFaultyItemLoading extends DeleteFaultyItemState {
  @override
  List<Object?> get props => [];
}

class DeleteFaultyItemSuccess extends DeleteFaultyItemState {
  final DeleteResponse deleteResponse;

  const DeleteFaultyItemSuccess(this.deleteResponse);

  @override
  List<Object?> get props => [deleteResponse];
}

class DeleteFaultyItemFail extends DeleteFaultyItemState {
  final String error;

  const DeleteFaultyItemFail(this.error);

  @override
  List<Object?> get props => [error];
}
