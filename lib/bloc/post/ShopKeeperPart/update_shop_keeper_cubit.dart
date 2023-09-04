import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/responsemodel/ShopKeeperResponsePart/EditShopKeeperResponse.dart';
import '../../../data/userRepository/UserRepository.dart';
import '../../../dataRequestModel/ShopKeeperPart/EditRequestModel.dart';

part 'update_shop_keeper_state.dart';

class UpdateShopKeeperCubit extends Cubit<UpdateShopKeeperState> {
  final UserRepository _userRepository;


  UpdateShopKeeperCubit(this._userRepository) : super(UpdateShopKeeperInitial());

  Future<void> updateShopKeeper(
      EditRequestModel updateShopKeeperRequestModel,int id) async {
    emit(UpdateShopKeeperLoading());
    try {
      final response =
      await _userRepository.updateShopKeeper(updateShopKeeperRequestModel,id);
      emit(UpdateShopKeeperSuccess(response));
    } catch (error) {
      emit(UpdateShopKeeperFail(error.toString()));
    }
  }
}