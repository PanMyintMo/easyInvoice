import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/responseModel/common/UpdateResponse.dart';
import '../../data/userRepository/UserRepository.dart';
import '../../dataRequestModel/EditCategoryModel.dart';

part 'edit_category_state.dart';

class EditCategoryCubit extends Cubit<EditCategoryState> {
  final UserRepository _userRepository;

  EditCategoryCubit(this._userRepository) : super(EditCategoryInitial());


  Future<void> editCategory(EditCategory editCategory, int id) async {
    emit(EditCategoryLoading());
    try {
      final respone = await _userRepository.updateCategory(editCategory, id);
      emit(EditCategorySuccess(respone));
    }
    catch (error) {
      emit(EditCategoryFail(error.toString()));
    }
  }
}
