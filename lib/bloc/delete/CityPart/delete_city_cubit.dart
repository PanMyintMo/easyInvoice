import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/responsemodel/CityPart/DeleteCityResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'delete_city_state.dart';

class DeleteCityCubit extends Cubit<DeleteCityState> {
  final UserRepository userRepository;

  DeleteCityCubit(this.userRepository) : super(DeleteCityInitial());

  Future<void> deleteCity(int id) async {
    emit(DeleteCityLoading());
    try {
      final response = await userRepository.deleteCity(id);
      emit(DeleteCitySuccess(response));
    } catch (error) {
      emit(DeleteCityFail(error.toString()));
    }
  }
}
