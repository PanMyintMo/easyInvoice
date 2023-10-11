import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../data/responseModel/common/DeleteResponse.dart';
import '../../data/userRepository/UserRepository.dart';

part 'delete_product_item_state.dart';

class DeleteProductItemCubit extends Cubit<DeleteProductItemState> {
  final UserRepository userRepository;

  DeleteProductItemCubit(this.userRepository) : super(DeleteProductItemInitial());

  Future<void> deleteProductItem(int id) async{
    emit(DeleteProductItemLoading());

    try{
      final response= await userRepository.deleteProductItem(id);
      emit(DeleteProductItemSuccess(response));
    }
    catch(error){
      emit(DeleteProductItemFail(error.toString()));
    }
  }

}
