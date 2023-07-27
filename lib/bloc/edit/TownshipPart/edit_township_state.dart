part of 'edit_township_cubit.dart';

abstract class EditTownshipState extends Equatable {
  const EditTownshipState();
}

class EditTownshipInitial extends EditTownshipState {
  @override
  List<Object> get props => [];
}
class EditTownshipLoading extends EditTownshipState {
  @override
  List<Object?> get props => [];
}
class EditTownshipSuccess extends EditTownshipState {
  final EditTownshipResponse townshipResponse;
  const EditTownshipSuccess(this.townshipResponse);
  @override
  List<Object?> get props => [townshipResponse];
}

class EditTownshipFail extends EditTownshipState {
  final String error;
  const EditTownshipFail(this.error);

  @override
  List<Object?> get props => [error];
}
