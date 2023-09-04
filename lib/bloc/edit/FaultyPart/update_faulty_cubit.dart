import 'package:bloc/bloc.dart';
import 'package:easy_invoice/dataRequestModel/ShopKeeperPart/EditRequestModel.dart';
import 'package:equatable/equatable.dart';

import '../../../data/responsemodel/ShopKeeperResponsePart/EditShopKeeperResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'update_faulty_state.dart';

class UpdateFaultyCubit extends Cubit<UpdateFaultyState> {
  final UserRepository _userRepository;

  UpdateFaultyCubit(this._userRepository) : super(UpdateFaultyInitial());

  Future<void> updateFaulty(int id, EditRequestModel editRequestModel) async {
    emit(UpdateFaultyLoading());
    try {
      final EditResponse response = await _userRepository.updateFaulty(editRequestModel,id);
      emit(UpdateFaultySuccess(response));
    } catch (error) {
      emit(UpdateFaultyFail(error.toString()));
    }
  }
}
