import 'package:bloc/bloc.dart';
import 'package:easy_invoice/data/responsemodel/GetAllSizeResponse.dart';
import 'package:equatable/equatable.dart';

import '../../../data/userRepository/UserRepository.dart';

part 'get_all_size_state.dart';

class GetAllSizeCubit extends Cubit<GetAllSizeState> {
  final UserRepository _userRepository;

  GetAllSizeCubit(this._userRepository) : super(GetAllSizeInitial());


  Future<void> getAllSizes() async {
    emit(GetAllSizeLoading());

    try {
      final List<SizeItems> response = await _userRepository.getSizes();
      emit(GetAllSizeSuccess(response));
    } catch (error) {
      emit(GetAllSizeFail(error.toString()));
    }
  }
}
