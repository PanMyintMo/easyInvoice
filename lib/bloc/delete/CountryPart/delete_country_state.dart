part of 'delete_country_cubit.dart';

abstract class DeleteCountryState extends Equatable {
  const DeleteCountryState();
}

class DeleteCountryInitial extends DeleteCountryState {
  @override
  List<Object> get props => [];
}


class DeleteCountryLoading extends DeleteCountryState {
  @override
  List<Object?> get props => [];
}

class DeleteCountrySuccess extends DeleteCountryState {
  final DeleteResponse deleteCountryResponse;

  const DeleteCountrySuccess(this.deleteCountryResponse);

  @override
  List<Object?> get props => [deleteCountryResponse];
}

class DeleteCountryFail extends DeleteCountryState {
  final String error;

  const DeleteCountryFail(this.error);

  @override
  List<Object?> get props => [error];
}
