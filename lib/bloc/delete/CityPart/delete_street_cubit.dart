import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/responsemodel/common/DeleteResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'delete_street_state.dart';

class DeleteStreetCubit extends Cubit<DeleteStreetState> {
  final UserRepository userRepository;

  DeleteStreetCubit(this.userRepository) : super(DeleteStreetInitial());

  Future<void> deleteStreet(int id) async {
    emit(DeleteStreetLoading());
    try {
      final response = await userRepository.deleteStreet(id);
      emit(DeleteStreetSuccess(response));
    } catch (error) {
      emit(DeleteStreetFail(error.toString()));
    }
  }
}