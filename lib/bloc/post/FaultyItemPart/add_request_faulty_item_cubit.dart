import 'package:bloc/bloc.dart';
import 'package:easy_invoice/data/responsemodel/FaultyItemPart/AddFaultyItemResponse.dart';
import 'package:easy_invoice/dataRequestModel/FaultyItemPart/AddFaultyItemRequest.dart';
import 'package:equatable/equatable.dart';

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
