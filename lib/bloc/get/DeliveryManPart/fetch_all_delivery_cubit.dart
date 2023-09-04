import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/responsemodel/DeliveryPart/FetchAllDeliveries.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'fetch_all_delivery_state.dart';

class FetchAllDeliveryCubit extends Cubit<FetchAllDeliveryState> {
  final UserRepository _userRepository;

  FetchAllDeliveryCubit(this._userRepository)
      : super(FetchAllDeliveryInitial());

  Future<void> fetchAllDelivery() async {
    emit(FetchAllDeliveryLoading());

    try {
      final List<DeliveriesItem> response = await _userRepository.fetchAllDelivery();
      emit(FetchAllDeliverySuccess(response));
    } catch (error) {
      emit(FetchAllDeliveryFail(error.toString()));
    }
  }
}