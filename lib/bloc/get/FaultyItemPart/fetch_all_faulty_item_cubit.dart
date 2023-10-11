import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/responseModel/FaultyItemPart/AllFaultyItems.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'fetch_all_faulty_item_state.dart';

class FetchAllFaultyItemCubit extends Cubit<FetchAllFaultyItemState> {
  final UserRepository _userRepository;

  FetchAllFaultyItemCubit(this._userRepository)
      : super(FetchAllFaultyItemInitial());

  Future<void> fetchAllFaultyItem() async {
    emit(FetchAllFaultyItemLoading());

    try {
      final response = await _userRepository.fetchAllFaultyItem();
      emit(FetchAllFaultyItemSuccess(response));
    } catch (error) {
      emit(FetchAllFaultyItemFail(error.toString()));
    }
  }
}