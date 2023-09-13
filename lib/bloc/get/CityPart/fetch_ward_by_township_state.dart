// part of 'fetch_ward_by_township_cubit.dart';
//
// abstract class FetchWardByTownshipState extends Equatable {
//   const FetchWardByTownshipState();
// }
//
// class FetchWardByTownshipInitial extends FetchWardByTownshipState {
//   @override
//   List<Object> get props => [];
// }
//
// class FetchWardByTownshipLoading extends FetchWardByTownshipState{
//   @override
//   List<Object?> get props => [];
// }
//
// class FetchWardByTownshipSuccess extends FetchWardByTownshipState{
//   final WardByTownshipResponse wardByTownshipResponse;
//   const FetchWardByTownshipSuccess(this.wardByTownshipResponse);
//   @override
//
//   List<Object?> get props => [wardByTownshipResponse];
//
// }
//
// class FetchWardByTownshipFail extends FetchWardByTownshipState{
//   final String error;
//   const FetchWardByTownshipFail(this.error);
//   @override
//   List<Object?> get props =>[error];
// }