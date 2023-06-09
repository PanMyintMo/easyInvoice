import 'package:bloc/bloc.dart';
import 'package:easy_invoice/data/responsemodel/GetAllCategoryDetail.dart';
import 'package:equatable/equatable.dart';
import '../../data/userRepository/UserRepository.dart';

part 'get_category_detail_state.dart';

class GetCategoryDetailCubit extends Cubit<GetCategoryDetailState> {
  final UserRepository _userRepository;

  GetCategoryDetailCubit(this._userRepository)
      : super(GetCategoryDetailInitial());

  Future<void> getCategoryDetail() async {
    emit(GetCategoryDetailLoading());

    try {
      final List<CategoryData> response = await _userRepository.getCategory();
      emit(GetCategoryDetailSuccess(response));
    } catch (error) {
      emit(GetCategoryDetailFail(error.toString()));
    }
  }

  // void deleteCategory(int id) {
  //   _userRepository.deleteCategory(id)
  //       .then((value) => emit (GetCategoryDetailSuccess(value as List<CategoryData>)))
  //       .catchError((e) =>emit (GetCategoryDetailFail("Can not delete")));
  // }
}
