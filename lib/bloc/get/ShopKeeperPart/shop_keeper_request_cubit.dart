import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/responsemodel/ShopKeeperResponsePart/ShopKeeperRequestResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'shop_keeper_request_state.dart';

class ShopKeeperRequestCubit extends Cubit<ShopKeeperRequestState> {
  final UserRepository _userRepository;

  ShopKeeperRequestCubit(this._userRepository)
      : super(ShopKeeperRequestInitial());

  Future<void> shopkeeperRequestList() async {
    emit(ShopKeeperRequestLoading());

    try {
      final  response = await _userRepository.shopKeeperRequestList();
      emit(ShopKeeperRequestSuccess(response.data));
    } catch (error) {
      emit(ShopKeeperRequestFail(error.toString()));
    }
  }
}