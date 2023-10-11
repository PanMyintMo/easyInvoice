import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/responseModel/common/DeleteResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'delete_ward_state.dart';

class DeleteWardCubit extends Cubit<DeleteWardState> {
  final UserRepository userRepository;

  DeleteWardCubit(this.userRepository) : super(DeleteWardInitial());

  Future<void> deleteWard(int id) async {
    emit(DeleteWardLoading());
    try {
      final response = await userRepository.deleteWard(id);
      emit(DeleteWardSuccess(response));
    } catch (error) {
      emit(DeleteWardFail(error.toString()));
    }
  }
}