part of 'edit_country_cubit.dart';

abstract class EditCountryState extends Equatable {
  const EditCountryState();
}

class EditCountryInitial extends EditCountryState {
  @override
  List<Object> get props => [];
}
class EditCountryLoading extends EditCountryState {
  @override
  List<Object?> get props => [];
}
class EditCountrySuccess extends EditCountryState {
  final EditCountryResponse country;
  const EditCountrySuccess(this.country);
  @override
  List<Object?> get props => [country];
}

class EditCountryFail extends EditCountryState {
  final String error;
  const EditCountryFail(this.error);

  @override
  List<Object?> get props => [error];
}

