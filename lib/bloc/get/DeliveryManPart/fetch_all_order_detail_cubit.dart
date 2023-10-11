import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/responseModel/DeliveryPart/OrderDetailResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'fetch_all_order_detail_state.dart';

class FetchAllOrderDetailCubit extends Cubit<FetchAllOrderDetailState> {
  final UserRepository _userRepository;

  FetchAllOrderDetailCubit(this._userRepository)
      : super(FetchAllOrderDetailInitial());

  Future<void> fetchOrderDetail(int id) async {
    emit(FetchAllOrderDetailLoading());

    try {
      final response = await _userRepository.fetchOrderDetail(id);
      emit(FetchAllOrderDetailSuccess(response));
    } catch (error) {
      emit(FetchAllOrderDetailFail(error.toString()));
    }
  }
}