 import 'package:bloc/bloc.dart';
 import 'package:easy_invoice/data/responsemodel/CategoryDeleteRespose.dart';
 import 'package:equatable/equatable.dart';

 import '../../data/userRepository/UserRepository.dart';

 part 'delete_category_state.dart';

 class DeleteCategoryCubit extends Cubit<DeleteCategoryState> {
   final UserRepository userRepository;

   DeleteCategoryCubit(this.userRepository) : super(DeleteCategoryInitial());

   Future<void> deleteCategory(int id) async{
     emit(DeleteCategoryLoading());

     try{
       final response= await userRepository.deleteCategory(id);
       emit(DeleteCategorySuccess(response));
     }
     catch(error){
       emit(DeleteCategoryFail(error.toString()));
     }
 }

 }
