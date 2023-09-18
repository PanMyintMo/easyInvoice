import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/responsemodel/DeliveryPart/OrderDetailResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'fetch_all_order_detail_state.dart';

class FetchAllOrderDetailCubit extends Cubit<FetchAllOrderDetailState> {
  final UserRepository _userRepository;

  FetchAllOrderDetailCubit(this._userRepository)
      : super(FetchAllOrderDetailInitial());

  Future<void> fetchOrderDetail(int id) async {
    emit(FetchAllOrderDetailLoading());

    try {
      final OrderDetailResponse response = await _userRepository.fetchOrderDetail(id);
      emit(FetchAllOrderDetailSuccess(response));
    } catch (error) {
      emit(FetchAllOrderDetailFail(error.toString()));
    }
  }
}