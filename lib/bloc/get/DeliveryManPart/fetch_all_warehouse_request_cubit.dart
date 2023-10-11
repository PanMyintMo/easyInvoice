import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/responseModel/DeliveryPart/DeliveryManResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'fetch_all_warehouse_request_state.dart';

class FetchAllWarehouseRequestCubit extends Cubit<FetchAllWarehouseRequestState> {
  final UserRepository _userRepository;

  FetchAllWarehouseRequestCubit(this._userRepository)
      : super(FetchAllWarehouseRequestInitial());

  Future<void> fetchAllWarehouseRequest() async {
    emit(FetchAllWarehouseRequestLoading());

    try {
      final List<DeliveryItemData> response = await _userRepository.fetchAllWarehouseRequest();
      emit(FetchAllWarehouseRequestSuccess(response));
    } catch (error) {
      emit(FetchAllWarehouseRequestFail(error.toString()));
    }
  }
}