import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../../data/responseModel/common/DeleteResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'delete_faulty_item_state.dart';

class DeleteFaultyItemCubit extends Cubit<DeleteFaultyItemState> {
  final UserRepository userRepository;

  DeleteFaultyItemCubit(this.userRepository) : super(DeleteFaultyItemInitial());

  Future<void> deleteFaultyItem(int id) async{
    emit(DeleteFaultyItemLoading());

    try{
      final response= await userRepository.deleteFaultyItem(id);
      emit(DeleteFaultyItemSuccess(response));
    }
    catch(error){
      emit(DeleteFaultyItemFail(error.toString()));
    }
  }

}
