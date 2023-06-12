import 'package:bloc/bloc.dart';
import 'package:easy_invoice/dataModel/EditCategoryModel.dart';
import 'package:equatable/equatable.dart';
import '../../data/responsemodel/UpdateCateResponse.dart';
import '../../data/userRepository/UserRepository.dart';

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
