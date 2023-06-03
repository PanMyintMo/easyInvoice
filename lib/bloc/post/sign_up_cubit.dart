import 'package:bloc/bloc.dart';
import 'package:easy_invoice/data/responsemodel/RegisterResponse.dart';
import 'package:easy_invoice/dataModel/RegisterRequestModel.dart';
import 'package:equatable/equatable.dart';
import '../../data/userRepository/UserRepository.dart';

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
