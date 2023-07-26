part of 'edit_city_cubit.dart';

abstract class EditCityState extends Equatable {
  const EditCityState();
}

class EditCityInitial extends EditCityState {
  @override
  List<Object> get props => [];
}
class EditCityLoading extends EditCityState {
  @override
  List<Object?> get props => [];
}
class EditCitySuccess extends EditCityState {
  final EditCityResponse cityResponse;
  const EditCitySuccess(this.cityResponse);
  @override
  List<Object?> get props => [cityResponse];
}

class EditCityFail extends EditCityState {
  final String error;
  const EditCityFail(this.error);

  @override
  List<Object?> get props => [error];
}
