// import 'package:bloc/bloc.dart';
// import 'package:easy_invoice/data/responsemodel/CityPart/WardByTownshipResponse.dart';
// import 'package:equatable/equatable.dart';
//
// import '../../../data/userRepository/UserRepository.dart';
//
// part 'fetch_ward_by_township_state.dart';
//
// class FetchWardByTownshipCubit extends Cubit<FetchWardByTownshipState> {
//   final UserRepository _userRepository;
//
//   FetchWardByTownshipCubit(this._userRepository) : super(FetchWardByTownshipInitial());
//
//   Future<void> fetchAllWardByTownshipId(int id) async {
//     emit(FetchWardByTownshipLoading());
//
//     try {
//       final WardByTownshipResponse response = await _userRepository.fetchWardByTownship(id);
//       emit(FetchWardByTownshipSuccess(response));
//     } catch (error) {
//       emit(FetchWardByTownshipFail(error.toString()));
//     }
//   }
// }
