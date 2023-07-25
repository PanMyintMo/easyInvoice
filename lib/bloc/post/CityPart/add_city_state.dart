part of 'add_city_cubit.dart';

abstract class AddCityState extends Equatable {
  const AddCityState();
}

class AddCityInitial extends AddCityState {
  @override
  List<Object> get props => [];
}
class AddCityLoading extends AddCityState {
  @override
  List<Object?> get props => [];
}
class AddCitySuccess extends AddCityState {
  final AddCityResponse cityResponse;
  const AddCitySuccess(this.cityResponse);
  @override
  List<Object?> get props => [cityResponse];
}

class AddCityFail extends AddCityState {
  final String error;
  const AddCityFail(this.error);

  @override
  List<Object?> get props => [error];
}

