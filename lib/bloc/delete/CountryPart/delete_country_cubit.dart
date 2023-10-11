import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/responseModel/common/DeleteResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'delete_country_state.dart';

class DeleteCountryCubit extends Cubit<DeleteCountryState> {
  final UserRepository userRepository;

  DeleteCountryCubit(this.userRepository) : super(DeleteCountryInitial());

  Future<void> deleteCountry(int id) async {
    emit(DeleteCountryLoading());
    try {
      final response = await userRepository.deleteCountry(id);
      emit(DeleteCountrySuccess(response));
    } catch (error) {
      emit(DeleteCountryFail(error.toString()));
    }
  }
}
