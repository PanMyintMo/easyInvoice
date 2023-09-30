import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/responsemodel/DeliveryPart/DeliveryCompanyInfoResponse.dart';
import '../../../data/userRepository/UserRepository.dart';
import '../../../dataRequestModel/DeliveryPart/AddDeliveryCompanyInfoRequestModel.dart';

part 'deli_company_info_state.dart';

class DeliCompanyInfoCubit extends Cubit<DeliCompanyInfoState> {
  final UserRepository _userRepository;

  DeliCompanyInfoCubit(this._userRepository) : super(DeliCompanyInfoInitial());

  Future<void> deliCompanyInfo(AddDeliCompanyInfoRequest addDeliCompanyInfoRequest) async {
    emit(DeliCompanyInfoLoading());
    try {
      final response = await _userRepository.deliCompanyInfo(addDeliCompanyInfoRequest);
      emit(DeliCompanyInfoSuccess(response));

    } catch (error) {
      emit(DeliCompanyInfoFail(error.toString()));
    }
  }
}
