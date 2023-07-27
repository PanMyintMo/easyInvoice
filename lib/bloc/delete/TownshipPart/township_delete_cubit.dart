import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/responsemodel/TownshipsPart/DeleteTownshipResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'township_delete_state.dart';

class TownshipDeleteCubit extends Cubit<TownshipDeleteState> {
  final UserRepository userRepository;

  TownshipDeleteCubit(this.userRepository) : super(TownshipDeleteInitial());

  Future<void> deleteTownship(int id) async {
    emit(DeleteTownshipLoading());
    try {
      final response = await userRepository.deleteTownship(id);
      emit(DeleteTownshipSuccess(response));
    } catch (error) {
      emit(DeleteTownshipFail(error.toString()));
    }
  }
}
