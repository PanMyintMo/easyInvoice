import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/responsemodel/DeliveryPart/AddOrderResponse.dart';
import '../../../data/userRepository/UserRepository.dart';
import '../../../dataRequestModel/DeliveryPart/AddOrderRequestModel.dart';

part 'add_order_state.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  final UserRepository _userRepository;

  AddOrderCubit(this._userRepository) : super(AddOrderInitial());

  Future<void> addOrder(AddOrderRequestModel addOrderRequestModel) async {
    emit(AddOrderLoading());
    try {
      final response = await _userRepository.addOrder(addOrderRequestModel);
      emit(AddOrderSuccess(response));

    } catch (error) {
      emit(AddOrderFail(error.toString()));
    }
  }
}
