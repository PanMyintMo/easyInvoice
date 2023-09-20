import 'package:bloc/bloc.dart';
import 'package:easy_invoice/data/responsemodel/common/DeleteResponse.dart';
import 'package:easy_invoice/dataRequestModel/DeliveryPart/ChangeOrderStatusRequestModel.dart';
import 'package:equatable/equatable.dart';

import '../../../data/userRepository/UserRepository.dart';

part 'change_order_status_state.dart';

class ChangeOrderStatusCubit extends Cubit<ChangeOrderStatusState> {
  final UserRepository _userRepository;

  ChangeOrderStatusCubit(this._userRepository) : super(ChangeOrderStatusInitial());

  Future<void> changeOrderStatus(ChangeOrderStatusRequestModel changeOrderStatusRequestModel) async {
    emit(ChangeOrderStatusLoading());
    try {
      final response = await _userRepository.changeOrderStatus(changeOrderStatusRequestModel);
      emit(ChangeOrderStatusSuccess(response));

    } catch (error) {
      emit(ChangeOrderStatusFail(error.toString()));
    }
  }
}
