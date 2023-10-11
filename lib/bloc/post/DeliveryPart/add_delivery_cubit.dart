import 'package:easy_invoice/dataRequestModel/DeliveryPart/AddDeliveryCompanyNameRequestModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/responseModel/DeliveryPart/AddDeliveryResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'add_delivery_state.dart';

class AddDeliveryCubit extends Cubit<AddDeliveryState> {
  final UserRepository _userRepository;

  AddDeliveryCubit(this._userRepository) : super(AddDeliveryInitial());

  Future<void> addDelivery(AddDeliveryRequestModel addDeliveryRequestModel) async {
    emit(AddDeliveryLoading());
    try {
      final response = await _userRepository.addDelivery(addDeliveryRequestModel);
      emit(AddDeliverySuccess(response));
      //  print(emit(SignUpSuccess(response)));
    } catch (error) {
      emit(AddDeliveryFail(error.toString()));
    }
  }
}
