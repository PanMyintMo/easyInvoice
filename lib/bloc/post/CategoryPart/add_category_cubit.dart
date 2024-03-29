import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/responseModel/AddCategoryResponseModel.dart';
import '../../../data/userRepository/UserRepository.dart';
import '../../../dataRequestModel/AddCategoryRequestModel.dart';

part 'add_category_state.dart';

class AddCategoryCubit extends Cubit<AddCategoryState> {
  final UserRepository _userRepository;


  AddCategoryCubit(this._userRepository) : super(AddCategoryInitial());

  Future<void> addCategory(
      AddCategoryRequestModel addCategoryRequestModel) async {
    emit(AddCategoryLoading());
    try {
      final response =
          await _userRepository.addCategory(addCategoryRequestModel);
      emit(AddCategorySuccess(response));
    } catch (error) {
      emit(AddCategoryFail(error.toString()));
    }
  }
}
