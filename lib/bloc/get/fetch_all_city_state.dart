part of 'fetch_all_city_cubit.dart';

abstract class FetchAllCityState extends Equatable {
  const FetchAllCityState();
}

class FetchAllCityInitial extends FetchAllCityState {
  @override
  List<Object> get props => [];
}

class FetchAllCityLoading extends FetchAllCityState{
  @override
  List<Object?> get props => [];
}

class FetchAllCitySuccess extends FetchAllCityState{
  final List<City> city;
  const FetchAllCitySuccess(this.city);
  @override

  List<Object?> get props => [city];

}

class FetchAllCityFail extends FetchAllCityState{
  final String error;
  const FetchAllCityFail(this.error);
  @override
  List<Object?> get props =>[error];
}