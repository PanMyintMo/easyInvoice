import 'package:easy_invoice/dataRequestModel/FaultyItemPart/AddFaultyItemRequest.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/responseModel/FaultyItemPart/AddFaultyItemResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'add_request_faulty_item_state.dart';

class AddRequestFaultyItemCubit extends Cubit<AddRequestFaultyItemState> {
  final UserRepository _userRepository;

  AddRequestFaultyItemCubit(this._userRepository) : super(AddRequestFaultyItemInitial());

  Future<void> addRequestFaultyItem(AddFaultyItemRequest addFaultyItemRequest) async {
    emit(AddRequestFaultyItemLoading());
    try {
      final response = await _userRepository.addRequestFaultyItem(addFaultyItemRequest);
      emit(AddRequestFaultyItemSuccess(response));
    } catch (error) {
      emit(AddRequestFaultyItemFail(error.toString()));
    }
  }
}
