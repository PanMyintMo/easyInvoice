import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/responseModel/common/DeleteResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'delivery_man_status_state.dart';

class DeliveryManStatusCubit extends Cubit<DeliveryManStatusState> {
  final UserRepository _userRepository;


  DeliveryManStatusCubit(this._userRepository) : super(DeliveryManStatusInitial());
  Future<void> deliveryManStatus(int id) async{
    emit(DeliveryManStatusLoading());

    try{
      final response= await _userRepository.deliveryManStatus(id);
      emit(DeliveryManStatusSuccess(response));
    }
    catch(error){
      emit(DeliveryManStatusFail(error.toString()));
    }
  }
}
