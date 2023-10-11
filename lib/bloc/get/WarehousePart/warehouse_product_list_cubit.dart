import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/responseModel/WarehousePart/WarehouseResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'warehouse_product_list_state.dart';

class WarehouseProductListCubit extends Cubit<WarehouseProductListState> {
  final UserRepository _userRepository;
  WarehouseProductListCubit(this._userRepository) : super(WarehouseProductListInitial());

  Future<void> warehouseProductList() async {
    emit(WarehouseProductListLoading());
    try {
      final response = await _userRepository.warehouse();

      final List<WarehouseData> warehouseData= response.data;

      emit(WarehouseProductListSuccess(warehouseData));
    } catch (error) {
      emit(WarehouseProductListFail(error.toString()));
    }
  }
}
