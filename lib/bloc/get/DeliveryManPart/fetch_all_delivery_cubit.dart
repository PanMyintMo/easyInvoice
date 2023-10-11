import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/responseModel/DeliveryPart/FetchAllDeliveries.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'fetch_all_delivery_state.dart';

class FetchAllDeliveryCubit extends Cubit<FetchAllDeliveryState> {
  final UserRepository _userRepository;

  FetchAllDeliveryCubit(this._userRepository)
      : super(FetchAllDeliveryInitial());

  Future<void> fetchAllDelivery() async {
    emit(FetchAllDeliveryLoading());

    try {
      final  response = await _userRepository.fetchAllDelivery();
      emit(FetchAllDeliverySuccess(response!));
    } catch (error) {
      emit(FetchAllDeliveryFail(error.toString()));
    }
  }
}