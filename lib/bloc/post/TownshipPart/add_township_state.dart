part of 'add_township_cubit.dart';

abstract class AddTownshipState extends Equatable {
  const AddTownshipState();
}

class AddTownshipInitial extends AddTownshipState {
  @override
  List<Object> get props => [];
}
class AddTownshipLoading extends AddTownshipState {
  @override
  List<Object?> get props => [];
}
class AddTownshipSuccess extends AddTownshipState {
  final AddTownshipResponse townshipResponse;
  const AddTownshipSuccess(this.townshipResponse);
  @override
  List<Object?> get props => [townshipResponse];
}

class AddTownshipFail extends AddTownshipState {
  final String error;
  const AddTownshipFail(this.error);

  @override
  List<Object?> get props => [error];
}