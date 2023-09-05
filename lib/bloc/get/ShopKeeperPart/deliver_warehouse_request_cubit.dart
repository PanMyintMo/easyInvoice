import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/responsemodel/ShopKeeperResponsePart/DeliveredWarehouseRequest.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'deliver_warehouse_request_state.dart';

class DeliverWarehouseRequestCubit extends Cubit<DeliverWarehouseRequestState> {
  final UserRepository _userRepository;

  DeliverWarehouseRequestCubit(this._userRepository)
      : super(DeliverWarehouseRequestInitial());

  Future<void> deliverWarehouseRequest() async {
    emit(DeliverWarehouseRequestLoading());

    try {
      final List<DeliveryWarehouseItem> response = await _userRepository.deliverWarehouseRequest();
      emit(DeliverWarehouseRequestSuccess(response));
    } catch (error) {
      emit(DeliverWarehouseRequestFail(error.toString()));
    }
  }
}