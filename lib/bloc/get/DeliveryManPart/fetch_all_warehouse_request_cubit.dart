import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/responsemodel/DeliveryPart/DeliveryManResponse.dart';
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