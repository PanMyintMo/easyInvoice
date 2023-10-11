import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/responseModel/common/DeleteResponse.dart';
import '../../data/userRepository/UserRepository.dart';

part 'delete_size_state.dart';

class DeleteSizeCubit extends Cubit<DeleteSizeState> {
  final UserRepository _userRepository;


  DeleteSizeCubit(this._userRepository) : super(DeleteSizeInitial());
  Future<void> deleteSize(int id) async{
    emit(DeleteSizeLoading());

    try{
      final response= await _userRepository.deleteSize(id);
      emit(DeleteSizeSuccess(response));
    }
    catch(error){
      emit(DeleteSizeFail(error.toString()));
    }
  }
}
