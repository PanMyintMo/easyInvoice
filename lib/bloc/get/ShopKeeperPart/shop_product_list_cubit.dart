import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/responseModel/ShopKeeperResponsePart/ShopProductListResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'shop_product_list_state.dart';

class ShopProductListCubit extends Cubit<ShopProductListState> {
  final UserRepository _userRepository;

  ShopProductListCubit(this._userRepository)
      : super(ShopProductListInitial());

  Future<void> shopProductList() async {
    emit(ShopProductListLoading());

    try {
      final response = await _userRepository.fetchAllShopProductList();
      emit(ShopProductListSuccess(response));
    } catch (error) {
      emit(ShopProductListFail(error.toString()));
    }
  }
}