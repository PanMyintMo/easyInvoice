/*
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/responsemodel/ProductByCategoryIdResponse.dart';
import '../../data/userRepository/UserRepository.dart';

part 'fetch_all_product_by_cate_id_state.dart';

class FetchAllProductByCateIdCubit extends Cubit<FetchAllProductByCateIdState> {
  final UserRepository _userRepository;
  FetchAllProductByCateIdCubit(this._userRepository) : super(FetchAllProductByCateIdInitial());

  Future<void> getAllProductByCateId(int id) async {
    emit(GetAllProductByCateIdLoading());

    try {
      final List<ProductItem> response = await _userRepository.fetchAllProductByCateId(id);
      emit(GetAllProductByCateIdSuccess(response));
    } catch (error) {
      emit(GetAllProductByCateIdFail(error.toString()));
    }
  }
}
*/
