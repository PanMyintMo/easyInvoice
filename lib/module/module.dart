import 'package:easy_invoice/bloc/delete/delete_category_cubit.dart';
import 'package:easy_invoice/bloc/edit/edit_category_cubit.dart';
import 'package:easy_invoice/bloc/get/get_category_detail_cubit.dart';
import 'package:easy_invoice/bloc/post/add_category_cubit.dart';
import 'package:easy_invoice/bloc/post/sign_in_cubit.dart';
import 'package:easy_invoice/bloc/post/sign_up_cubit.dart';
import 'package:easy_invoice/data/api/apiService.dart';
import 'package:easy_invoice/data/userRepository/UserRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

var getIt = GetIt.instance;

void locator() {
  Dio dio = Dio();
  getIt.registerLazySingleton(() => dio);

  ApiService apiService = ApiService();
  getIt.registerLazySingleton(() => apiService);

  UserRepository userRepository = UserRepository();
  getIt.registerLazySingleton<UserRepository>(() => userRepository);
  //for login
  SignInCubit signInCubit = SignInCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => signInCubit);
  //for register
  SignUpCubit signupCubit = SignUpCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => signupCubit);
  //to add category to db
  AddCategoryCubit addCategoryCubit =
      AddCategoryCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => addCategoryCubit);
  //get all category
  GetCategoryDetailCubit getCategoryDetailCubit =
      GetCategoryDetailCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => getCategoryDetailCubit);

  //to delete category
  DeleteCategoryCubit categoryDeleteCubit= DeleteCategoryCubit(getIt.call());
  getIt.registerLazySingleton(() => categoryDeleteCubit);

  //to update category
  EditCategoryCubit editCategoryCubit= EditCategoryCubit(getIt.call());
  getIt.registerLazySingleton(() => editCategoryCubit);
}
