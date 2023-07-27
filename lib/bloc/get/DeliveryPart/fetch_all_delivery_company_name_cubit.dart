/*
import 'package:bloc/bloc.dart';
import 'package:easy_invoice/data/responsemodel/DeliveryPart/FetchAllDeliveryName.dart';
import 'package:equatable/equatable.dart';

import '../../../data/userRepository/UserRepository.dart';

part 'fetch_all_delivery_company_name_state.dart';

class FetchAllDeliveryCompanyNameCubit extends Cubit<FetchAllDeliveryCompanyNameState> {
  final UserRepository _userRepository;

  FetchAllDeliveryCompanyNameCubit(this._userRepository) : super(FetchAllDeliveryCompanyNameInitial());


  Future<void> fetchDeliveryCompanyName() async {
    emit(FetchAllDeliveryCompanyNameLoading());

    try {
      final List<AllDeliveryName> response = await _userRepository.fetchAllDeliveryCompanyName();
      emit(FetchAllDeliveryCompanyNameSuccess(response));
    } catch (error) {
      emit(FetchAllDeliveryCompanyNameFail(error.toString()));
    }
  }
}
*/
