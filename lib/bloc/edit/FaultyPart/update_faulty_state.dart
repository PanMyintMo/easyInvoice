part of 'update_faulty_cubit.dart';

abstract class UpdateFaultyState extends Equatable {
  const UpdateFaultyState();
}

class UpdateFaultyInitial extends UpdateFaultyState {
  @override
  List<Object> get props => [];
}
class  UpdateFaultyLoading extends UpdateFaultyState {
  @override
  List<Object?> get props => [];
}
class  UpdateFaultySuccess extends UpdateFaultyState {
  final EditResponse response;
  const UpdateFaultySuccess(this.response);
  @override
  List<Object?> get props => [response];
}

class  UpdateFaultyFail extends UpdateFaultyState {
  final String error;
  const UpdateFaultyFail(this.error);

  @override
  List<Object?> get props => [error];
}