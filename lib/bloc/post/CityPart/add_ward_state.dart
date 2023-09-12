part of 'add_ward_cubit.dart';

abstract class AddWardState extends Equatable {
  const AddWardState();
}

class AddWardInitial extends AddWardState {
  @override
  List<Object> get props => [];
}
class AddWardLoading extends AddWardState {
  @override
  List<Object?> get props => [];
}
class AddWardSuccess extends AddWardState {
  final AddWardResponse addWardResponse;
  const AddWardSuccess(this.addWardResponse);
  @override
  List<Object?> get props => [addWardResponse];
}

class AddWardFail extends AddWardState {
  final String error;
  const AddWardFail(this.error);

  @override
  List<Object?> get props => [error];
}