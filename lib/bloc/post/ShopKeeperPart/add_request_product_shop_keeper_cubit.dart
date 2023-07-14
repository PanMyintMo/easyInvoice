import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/responsemodel/ShopKeeperResponsePart/ShopKeeperResponse.dart';
import '../../../data/userRepository/UserRepository.dart';
import '../../../dataRequestModel/ShopKeeperPart/ShopKeeperRequestModel.dart';

part 'add_request_product_shop_keeper_state.dart';

class AddRequestProductShopKeeperCubit extends Cubit<AddRequestProductShopKeeperState> {
  final UserRepository _userRepository;


  AddRequestProductShopKeeperCubit(this._userRepository) : super(AddRequestProductShopKeeperInitial());

  Future<void> addRequestShopkeeperProduct(
      ShopKeeperRequestModel shopKeeperRequestModel) async {
    emit(AddRequestProductShopKeeperLoading());
    try {
      final response =
      await _userRepository.addShopKeeperRequestProduct(shopKeeperRequestModel);
      emit(AddRequestProductShopKeeperSuccess(response));
    } catch (error) {
      emit(AddRequestProductShopKeeperFail(error.toString()));
    }
  }
}