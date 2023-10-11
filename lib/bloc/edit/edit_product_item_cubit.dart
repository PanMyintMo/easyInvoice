import 'package:easy_invoice/dataRequestModel/EditProductRequestModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/responseModel/EditProductResponse.dart';
import '../../data/userRepository/UserRepository.dart';
part 'edit_product_item_state.dart';

class EditProductItemCubit extends Cubit<EditProductItemState> {
  final UserRepository _userRepository;
  EditProductItemCubit(this._userRepository) : super(EditProductItemInitial());

  Future<bool> editProductItem(EditProductRequestModel editProductRequestModel, int id) async {
    emit(EditProductItemLoading());
    try {
      final response = await _userRepository.updateProductItem(editProductRequestModel, id);
      emit(EditProductItemSuccess(response));
      return true;
    }
    catch (error) {
      emit(EditProductItemFail(error.toString()));
      return false;
    }
  }
}
