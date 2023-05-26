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

  ApiService apiService = ApiService(getIt.call());
  getIt.registerLazySingleton(() => apiService);

  UserRepository userRepository = UserRepository();
  getIt.registerLazySingleton<UserRepository>(() => userRepository);

  SignInCubit signInCubit = SignInCubit(getIt.call());
  getIt.registerLazySingleton(() => signInCubit);

  SignUpCubit signupCubit = SignUpCubit(getIt.call());
  getIt.registerLazySingleton(() => signupCubit);



}
