part of 'request_country_cubit.dart';

abstract class RequestCountryState extends Equatable {
  const RequestCountryState();
}

class RequestCountryInitial extends RequestCountryState {
  @override
  List<Object> get props => [];
}

class RequestCountryLoading extends RequestCountryState {
  @override
  List<Object?> get props => [];
}
class RequestCountrySuccess extends RequestCountryState {
  final List<Country> country;
  const RequestCountrySuccess(this.country);
  @override
  List<Object?> get props => [country];
}

class RequestCountryFail extends RequestCountryState {
  final String error;
  const RequestCountryFail(this.error);

  @override
  List<Object?> get props => [error];
}

