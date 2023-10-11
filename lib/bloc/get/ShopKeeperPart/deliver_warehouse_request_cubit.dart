import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/responseModel/ShopKeeperResponsePart/DeliveredWarehouseRequest.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'deliver_warehouse_request_state.dart';

class DeliverWarehouseRequestCubit extends Cubit<DeliverWarehouseRequestState> {
  final UserRepository _userRepository;

  DeliverWarehouseRequestCubit(this._userRepository)
      : super(DeliverWarehouseRequestInitial());

  Future<void> deliverWarehouseRequest() async {
    emit(DeliverWarehouseRequestLoading());

    try {
      final response = await _userRepository.deliverWarehouseRequest();
      emit(DeliverWarehouseRequestSuccess(response));
    } catch (error) {
      emit(DeliverWarehouseRequestFail(error.toString()));
    }
  }
}