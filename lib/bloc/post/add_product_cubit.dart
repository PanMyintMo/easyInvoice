import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/responsemodel/ProductResponse.dart';
import '../../data/userRepository/UserRepository.dart';
import '../../dataRequestModel/AddProductRequestModel.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {

  final UserRepository _userRepository;

  AddProductCubit(this._userRepository) : super(AddProductInitial());

  Future<void> addProduct(
      AddProductRequestModel addProductRequestModel) async {
    emit(AddProductLoading());
    try {
      final response =
      await _userRepository.addProduct(addProductRequestModel);
      emit(AddProductSuccess(response));
    } catch (error) {
      emit(AddProductFail(error.toString()));
    }
  }
}
