part of 'fetch_all_ward_cubit.dart';

abstract class FetchAllWardState extends Equatable {
  const FetchAllWardState();
}

class FetchAllWardInitial extends FetchAllWardState {
  @override
  List<Object> get props => [];
}

class FetchAllWardLoading extends FetchAllWardState{
  @override
  List<Object?> get props => [];
}

class FetchAllWardSuccess extends FetchAllWardState{
  final List<Ward> ward;
  const FetchAllWardSuccess(this.ward);
  @override

  List<Object?> get props => [ward];

}

class FetchAllWardFail extends FetchAllWardState{
  final String error;
  const FetchAllWardFail(this.error);
  @override
  List<Object?> get props =>[error];
}