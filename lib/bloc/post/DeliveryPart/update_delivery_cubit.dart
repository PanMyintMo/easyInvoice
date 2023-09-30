import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/responsemodel/DeliveryPart/DeliveryCompanyInfoResponse.dart';
import '../../../data/userRepository/UserRepository.dart';
import '../../../dataRequestModel/DeliveryPart/UpdateDeliveryRequestModel.dart';

part 'update_delivery_state.dart';

class UpdateDeliveryCubit extends Cubit<UpdateDeliveryState> {
  final UserRepository _userRepository;

  UpdateDeliveryCubit(this._userRepository) : super(UpdateDeliveryInitial());

  Future<void> updateDeliveryById(int id,UpdateDeliveryRequestModel updateDeliveryRequestModel) async {
    emit(UpdateDeliveryLoading());
    try {
      final response = await _userRepository.updateDeliveryById(id,updateDeliveryRequestModel);
      emit(UpdateDeliverySuccess(response));

    } catch (error) {
      emit(UpdateDeliveryFail(error.toString()));
    }
  }
}
