import 'package:bloc/bloc.dart';
import 'package:easy_invoice/data/responsemodel/AddSizeResponse.dart';
import 'package:easy_invoice/dataModel/AddSizeRequestModel.dart';
import 'package:equatable/equatable.dart';

import '../../data/userRepository/UserRepository.dart';

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
