import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/responseModel/common/DeleteResponse.dart';
import '../../../data/userRepository/UserRepository.dart';

part 'delete_shop_keeper_product_request_state.dart';

class DeleteShopKeeperProductRequestCubit extends Cubit<DeleteShopKeeperProductRequestState> {
  final UserRepository userRepository;

  DeleteShopKeeperProductRequestCubit(this.userRepository) : super(DeleteShopKeeperProductRequestInitial());

  Future<void> deleteShopKeeperRequestProduct(int id) async{
    emit(DeleteShopKeeperProductRequestLoading());

    try{
      final response= await userRepository.deleteShopKeeperRequestProduct(id);
      emit(DeleteShopKeeperProductRequestSuccess(response));
    }
    catch(error){
      emit(DeleteShopKeeperProductRequestItemFail(error.toString()));
    }
  }

}
