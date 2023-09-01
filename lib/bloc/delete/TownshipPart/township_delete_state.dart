part of 'township_delete_cubit.dart';

abstract class TownshipDeleteState extends Equatable {
  const TownshipDeleteState();
}

class TownshipDeleteInitial extends TownshipDeleteState {
  @override
  List<Object> get props => [];
}

class DeleteTownshipLoading extends TownshipDeleteState {
  @override
  List<Object?> get props => [];
}

class DeleteTownshipSuccess extends TownshipDeleteState {
  final DeleteResponse deleteTownshipResponse;

  const DeleteTownshipSuccess(this.deleteTownshipResponse);

  @override
  List<Object?> get props => [deleteTownshipResponse];
}

class DeleteTownshipFail extends TownshipDeleteState {
  final String error;

  const DeleteTownshipFail(this.error);

  @override
  List<Object?> get props => [error];
}