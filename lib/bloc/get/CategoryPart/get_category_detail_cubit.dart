import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/responsemodel/GetAllPagnitaionDataResponse.dart';
import '../../../data/userRepository/UserRepository.dart';
part 'get_category_detail_state.dart';

class GetCategoryDetailCubit extends Cubit<GetCategoryDetailState> {
  final UserRepository _userRepository;

  GetCategoryDetailCubit(this._userRepository)
      : super(GetCategoryDetailInitial());

  Future<void> getCategoryDetail() async {
    emit(GetCategoryDetailLoading());

    try {
      final List<PaginationItem>? response = await _userRepository.getCategory();
      emit(GetCategoryDetailSuccess(response!));
    } catch (error) {
      emit(GetCategoryDetailFail(error.toString()));
    }
  }
}