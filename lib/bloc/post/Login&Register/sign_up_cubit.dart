import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/responseModel/GeneralMainResponse/RegisterResponse.dart';
import '../../../data/userRepository/UserRepository.dart';
import '../../../dataRequestModel/Login&Register/RegisterRequestModel.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final UserRepository _userRepository;
  SignUpCubit(this._userRepository) : super(SignUpInitial());


  Future<void> signUp(RegisterRequestModel registerRequestModel) async {
    emit(SignUpLoading());

    try {
      final response = await _userRepository.signUp(registerRequestModel);
      emit(SignUpSuccess(response));
    //  print(emit(SignUpSuccess(response)));
    } catch (error) {
      emit(SignUpFail(error.toString()));
    }
  }
}
