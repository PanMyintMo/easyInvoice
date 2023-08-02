import 'package:bloc/bloc.dart';
import 'package:easy_invoice/data/responsemodel/Login&RegisterResponse/CompanyProfileResponse.dart';
import 'package:equatable/equatable.dart';

import '../../../data/userRepository/UserRepository.dart';

part 'company_profile_state.dart';

class CompanyProfileCubit extends Cubit<CompanyProfileState> {
  final UserRepository _userRepository;

  CompanyProfileCubit(this._userRepository) : super(CompanyProfileInitial());

  Future<void> companyProfile() async {
    emit(CompanyProfileLoading());
    try {
      final response = await _userRepository.companyProfile();
      emit(CompanyProfileSuccess(response.data));

    } catch (error) {
      emit(CompanyProfileFail(error.toString()));
    }
  }
}
