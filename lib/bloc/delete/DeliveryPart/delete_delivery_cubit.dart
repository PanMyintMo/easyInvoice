import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../../data/responseModel/common/DeleteResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'delete_delivery_state.dart';

class DeleteDeliveryCubit extends Cubit<DeleteDeliveryState> {
  final UserRepository userRepository;

  DeleteDeliveryCubit(this.userRepository) : super(DeleteDeliveryInitial());

  Future<void> deleteDelivery(int id) async{
    emit(DeleteDeliveryLoading());

    try{
      final response= await userRepository.deleteDelivery(id);
      emit(DeleteDeliverySuccess(response));
    }
    catch(error){
      emit(DeleteDeliveryFail(error.toString()));
    }
  }

}
