import 'package:bloc/bloc.dart';
import 'package:easy_invoice/data/responsemodel/MainPagePart/MainPageResponse.dart';
import 'package:equatable/equatable.dart';

import '../../../data/userRepository/UserRepository.dart';
import '../../../dataRequestModel/DeliveryPart/OrderByDateRequestModel.dart';

part 'fetch_order_by_date_state.dart';

class FetchOrderByDateCubit extends Cubit<FetchOrderByDateState> {
  final UserRepository _userRepository;

  FetchOrderByDateCubit(this._userRepository) : super(FetchOrderByDateInitial());


  Future<void> orderFilterByDate(OrderByDateRequest orderByDateRequest) async {
    emit(FetchOrderByDateLoading());

    try {
      final List<OrderDatas>? response = await _userRepository.allOrderByDate(orderByDateRequest);
      emit(FetchOrderByDateSuccess(response!));
    } catch (error) {
      emit(FetchOrderByDateFail(error.toString()));
    }
  }
}
