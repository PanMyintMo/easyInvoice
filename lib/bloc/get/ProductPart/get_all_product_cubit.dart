import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/responseModel/common/ProductListItemResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'get_all_product_state.dart';

class GetAllProductCubit extends Cubit<GetAllProductState> {
  final UserRepository _userRepository;

  GetAllProductCubit(this._userRepository) : super(GetAllProductInitial());

  Future<void> getAllProduct() async {
    emit(GetAllProductLoading());

    try {
      final response = await _userRepository.fetchAllProduct();
      emit(GetAllProductSuccess(response!));
    } catch (error) {
      emit(GetAllProductFail(error.toString()));
    }
  }
}
