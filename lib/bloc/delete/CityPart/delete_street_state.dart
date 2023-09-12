part of 'delete_street_cubit.dart';

abstract class DeleteStreetState extends Equatable {
  const DeleteStreetState();
}

class DeleteStreetInitial extends DeleteStreetState {
  @override
  List<Object> get props => [];
}
class DeleteStreetLoading extends DeleteStreetState {
  @override
  List<Object?> get props => [];
}

class DeleteStreetSuccess extends DeleteStreetState {
  final DeleteResponse deleteStreetResponse;

  const DeleteStreetSuccess(this.deleteStreetResponse);

  @override
  List<Object?> get props => [deleteStreetResponse];
}

class DeleteStreetFail extends DeleteStreetState {
  final String error;

  const DeleteStreetFail(this.error);

  @override
  List<Object?> get props => [error];
}