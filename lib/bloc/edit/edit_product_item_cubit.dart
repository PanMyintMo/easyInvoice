import 'package:bloc/bloc.dart';
import 'package:easy_invoice/data/responsemodel/EditProductResponse.dart';
import 'package:easy_invoice/dataRequestModel/EditProductRequestModel.dart';
import 'package:equatable/equatable.dart';
import '../../data/userRepository/UserRepository.dart';
part 'edit_product_item_state.dart';

class EditProductItemCubit extends Cubit<EditProductItemState> {
  final UserRepository _userRepository;
  EditProductItemCubit(this._userRepository) : super(EditProductItemInitial());

  Future<bool> editProductItem(EditProductRequestModel editProductRequestModel, int id) async {
    emit(EditProductItemLoading());
    try {
      final respone = await _userRepository.updateProductItem(editProductRequestModel, id);
      emit(EditProductItemSuccess(respone));
      return true;
    }
    catch (error) {
      emit(EditProductItemFail(error.toString()));
      return false;
    }
  }
}
