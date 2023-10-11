import 'package:easy_invoice/dataRequestModel/Login&Register/EditCompanyProfileRequestModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/responseModel/GeneralMainResponse/EditCompanyProfileResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'edit_company_profile_state.dart';

class EditCompanyProfileCubit extends Cubit<EditCompanyProfileState> {
  final UserRepository _userRepository;

  EditCompanyProfileCubit(this._userRepository) : super(EditCompanyProfileInitial());

  Future<void> editCompanyProfile(EditCompanyProfileRequestModel editProfileRequestModel,int id) async {
    emit(EditCompanyProfileLoading());
    try {
      final response = await _userRepository.editCompanyProfile(editProfileRequestModel,id);
      emit(EditCompanyProfileSuccess(response));
      //  print(emit(SignUpSuccess(response)));
    } catch (error) {
      emit(EditCompanyProfileFail(error.toString()));
    }
  }
}
