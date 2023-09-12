part of 'add_street_cubit.dart';

abstract class AddStreetState extends Equatable {
  const AddStreetState();
}

class AddStreetInitial extends AddStreetState {
  @override
  List<Object> get props => [];
}
class AddStreetLoading extends AddStreetState {
  @override
  List<Object?> get props => [];
}
class AddStreetSuccess extends AddStreetState {
  final AddStreetResponse addStreetResponse;
  const AddStreetSuccess(this.addStreetResponse);
  @override
  List<Object?> get props => [addStreetResponse];
}

class AddStreetFail extends AddStreetState {
  final String error;
  const AddStreetFail(this.error);

  @override
  List<Object?> get props => [error];
}