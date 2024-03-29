import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/responseModel/MainPagePart/MainPageResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'order_filter_by_date_state.dart';

class OrderFilterByDateCubit extends Cubit<OrderFilterByDateState> {
  final UserRepository _userRepository;
  OrderFilterByDateCubit(this._userRepository) : super(OrderFilterByDateInitial());

  Future<void> fetchDataForDifferentFilterTypes(String filterType) async {
    emit(OrderFilterByDateLoading());
    try {
      final responses = await _userRepository.fetchDataForDifferentFilterTypes(filterType);

      // Use the filterType parameter to get the appropriate response
      OrderApiResponse selectedResponse = responses!;

      emit(OrderFilterByDateSuccess(
        selectedResponse: selectedResponse,
        // You can omit the other responses from this emit
      ));
    } catch (error) {
      emit(OrderFilterByDateFail(error.toString()));
    }
  }
}
