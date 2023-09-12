part of 'delete_ward_cubit.dart';

abstract class DeleteWardState extends Equatable {
  const DeleteWardState();
}

class DeleteWardInitial extends DeleteWardState {
  @override
  List<Object> get props => [];
}
class DeleteWardLoading extends DeleteWardState {
  @override
  List<Object?> get props => [];
}

class DeleteWardSuccess extends DeleteWardState {
  final DeleteResponse deleteWardResponse;

  const DeleteWardSuccess(this.deleteWardResponse);

  @override
  List<Object?> get props => [deleteWardResponse];
}

class DeleteWardFail extends DeleteWardState {
  final String error;

  const DeleteWardFail(this.error);

  @override
  List<Object?> get props => [error];
}