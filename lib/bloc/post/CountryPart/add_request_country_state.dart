part of 'add_request_country_cubit.dart';

abstract class AddRequestCountryState extends Equatable {
  const AddRequestCountryState();
}

class AddRequestCountryInitial extends AddRequestCountryState {
  @override
  List<Object> get props => [];
}
class AddRequestCountryLoading extends AddRequestCountryState {
  @override
  List<Object?> get props => [];
}
class AddRequestCountrySuccess extends AddRequestCountryState {
  final RequestCountryResponse requestCountryResponse;
  const AddRequestCountrySuccess(this.requestCountryResponse);
  @override
  List<Object?> get props => [requestCountryResponse];
}

class AddRequestCountryFail extends AddRequestCountryState {
  final String error;
  const AddRequestCountryFail(this.error);

  @override
  List<Object?> get props => [error];
}

