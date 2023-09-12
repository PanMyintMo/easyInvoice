part of 'fetch_all_street_cubit.dart';

abstract class FetchAllStreetState extends Equatable {
  const FetchAllStreetState();
}

class FetchAllStreetInitial extends FetchAllStreetState {
  @override
  List<Object> get props => [];
}
class FetchAllStreetLoading extends FetchAllStreetState{
  @override
  List<Object?> get props => [];
}

class FetchAllStreetSuccess extends FetchAllStreetState{
  final List<Street> street;
  const FetchAllStreetSuccess(this.street);
  @override

  List<Object?> get props => [street];

}

class FetchAllStreetFail extends FetchAllStreetState{
  final String error;
  const FetchAllStreetFail(this.error);
  @override
  List<Object?> get props =>[error];
}