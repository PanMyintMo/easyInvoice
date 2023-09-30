import 'package:bloc/bloc.dart';
import 'package:easy_invoice/dataRequestModel/DeliveryPart/EditOrderDetailRequestModel.dart';
import 'package:equatable/equatable.dart';

import '../../../data/responsemodel/DeliveryPart/AddOrderResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'edit_order_detail_state.dart';

class EditOrderDetailCubit extends Cubit<EditOrderDetailState> {
  final UserRepository _userRepository;

  EditOrderDetailCubit(this._userRepository) : super(EditOrderDetailInitial());

  Future<void> updateOrderDetail(int id, EditOrderDetailRequestModel editOrderDetailRequestModel) async {
    emit(EditOrderDetailLoading());
    try {
      final OrderResponse response = await _userRepository.editOrderDetail(id, editOrderDetailRequestModel);
      emit(EditOrderDetailSuccess(response));
    } catch (error) {
      emit(EditOrderDetailFail(error.toString()));
    }
  }
}
