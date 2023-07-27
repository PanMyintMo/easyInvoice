part of 'fetch_all_township_cubit.dart';

abstract class FetchAllTownshipState extends Equatable {
  const FetchAllTownshipState();
}

class FetchAllTownshipInitial extends FetchAllTownshipState {
  @override
  List<Object> get props => [];
}
class FetchAllTownshipLoading extends FetchAllTownshipState{
  @override
  List<Object?> get props => [];
}

class FetchAllTownshipSuccess extends FetchAllTownshipState{
  final List<Township> township;
  const FetchAllTownshipSuccess(this.township);
  @override

  List<Object?> get props => [township];

}

class FetchAllTownshipFail extends FetchAllTownshipState{
  final String error;
  const FetchAllTownshipFail(this.error);
  @override
  List<Object?> get props =>[error];
}