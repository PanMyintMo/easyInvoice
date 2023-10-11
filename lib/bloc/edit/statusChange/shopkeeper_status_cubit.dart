import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/responseModel/common/DeleteResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'shopkeeper_status_state.dart';

class ShopkeeperStatusCubit extends Cubit<ShopkeeperStatusState> {
  final UserRepository _userRepository;
  ShopkeeperStatusCubit(this._userRepository) : super(ShopkeeperStatusInitial());
  Future<void> shopkeeperStatus(int id) async{
    emit(ShopkeeperStatusLoading());

    try{
      final response= await _userRepository.shopkeeperStatus(id);
      emit(ShopkeeperStatusSuccess(response));
    }
    catch(error){
      emit(ShopkeeperStatusFail(error.toString()));
    }
  }
}
