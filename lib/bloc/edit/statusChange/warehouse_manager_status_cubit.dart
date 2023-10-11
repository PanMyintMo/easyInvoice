import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/responseModel/common/DeleteResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'warehouse_manager_status_state.dart';

class WarehouseManagerStatusCubit extends Cubit<WarehouseManagerStatusState> {
  final UserRepository _userRepository;


  WarehouseManagerStatusCubit(this._userRepository) : super(WarehouseManagerStatusInitial());
  Future<void> warehouseManagerStatus(int id) async{
    emit(WarehouseManagerStatusLoading());

    try{
      final response= await _userRepository.warehouseManagerStatus(id);
      emit(WarehouseManagerStatusSuccess(response));
    }
    catch(error){
      emit(WarehouseManagerStatusFail(error.toString()));
    }
  }
}
