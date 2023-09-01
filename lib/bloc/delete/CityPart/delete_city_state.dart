part of 'delete_city_cubit.dart';

abstract class DeleteCityState extends Equatable {
  const DeleteCityState();
}

class DeleteCityInitial extends DeleteCityState {
  @override
  List<Object> get props => [];
}

class DeleteCityLoading extends DeleteCityState {
  @override
  List<Object?> get props => [];
}

class DeleteCitySuccess extends DeleteCityState {
  final DeleteResponse deleteCityResponse;

  const DeleteCitySuccess(this.deleteCityResponse);

  @override
  List<Object?> get props => [deleteCityResponse];
}

class DeleteCityFail extends DeleteCityState {
  final String error;

  const DeleteCityFail(this.error);

  @override
  List<Object?> get props => [error];
}