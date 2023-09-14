part of 'edit_ward_cubit.dart';

abstract class EditWardState extends Equatable {
  const EditWardState();
}

class EditWardInitial extends EditWardState {
  @override
  List<Object> get props => [];
}
class EditWardLoading extends EditWardState {
  @override
  List<Object?> get props => [];
}
class EditWardSuccess extends EditWardState {
  final EditWardResponse editWardResponse;
  const EditWardSuccess(this.editWardResponse);
  @override
  List<Object?> get props => [editWardResponse];
}

class EditWardFail extends EditWardState {
  final String error;
  const EditWardFail(this.error);

  @override
  List<Object?> get props => [error];
}
