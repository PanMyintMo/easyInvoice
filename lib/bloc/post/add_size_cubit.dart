
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/responseModel/AddSizeResponse.dart';
import '../../data/userRepository/UserRepository.dart';
import '../../dataRequestModel/AddSizeRequestModel.dart';
part 'add_size_state.dart';


class AddSizeCubit extends Cubit<AddSizeState> {

  final UserRepository _userRepository;


  AddSizeCubit(this._userRepository) : super(AddSizeInitial());

  Future<void> addSize(
      AddSizeRequestModel addSizeRequestModel) async {
    emit(AddSizeLoading());
    try {
      final response =
      await _userRepository.addSize(addSizeRequestModel);
      emit(AddSizeSuccess(response));
    } catch (error) {
      emit(AddSizeFail(error.toString()));
    }
  }
}
