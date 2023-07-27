import 'package:easy_invoice/bloc/delete/delete_category_cubit.dart';
import 'package:easy_invoice/bloc/delete/delete_size_cubit.dart';
import 'package:easy_invoice/bloc/edit/edit_category_cubit.dart';
import 'package:easy_invoice/bloc/edit/edit_product_item_cubit.dart';
import 'package:easy_invoice/bloc/edit/edit_size_cubit.dart';
import 'package:easy_invoice/bloc/edit/edit_user_role_cubit.dart';
import 'package:easy_invoice/bloc/get/CityPart/fetch_all_city_cubit.dart';
import 'package:easy_invoice/bloc/get/get_all_product_cubit.dart';
import 'package:easy_invoice/bloc/get/get_all_size_cubit.dart';
import 'package:easy_invoice/bloc/get/get_all_user_role_cubit.dart';
import 'package:easy_invoice/bloc/get/get_category_detail_cubit.dart';
import 'package:easy_invoice/bloc/post/DeliveryPart/add_delivery_cubit.dart';
import 'package:easy_invoice/bloc/post/ShopKeeperPart/add_request_product_shop_keeper_cubit.dart';
import 'package:easy_invoice/bloc/post/TownshipPart/add_township_cubit.dart';
import 'package:easy_invoice/bloc/post/add_category_cubit.dart';
import 'package:easy_invoice/bloc/post/add_product_cubit.dart';
import 'package:easy_invoice/bloc/post/sign_in_cubit.dart';
import 'package:easy_invoice/bloc/post/sign_up_cubit.dart';
import 'package:easy_invoice/bloc/post/add_user_role_cubit.dart';
import 'package:easy_invoice/data/api/apiService.dart';
import 'package:easy_invoice/data/userRepository/UserRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../bloc/delete/CityPart/delete_city_cubit.dart';
import '../bloc/delete/CountryPart/delete_country_cubit.dart';
import '../bloc/delete/delete_product_item_cubit.dart';
import '../bloc/delete/delete_user_role_cubit.dart';
import '../bloc/edit/CityPart/edit_city_cubit.dart';
import '../bloc/edit/TownshipPart/edit_township_cubit.dart';
import '../bloc/get/DeliveryPart/fetch_all_delivery_company_name_cubit.dart';
import '../bloc/get/TownshipPart/fetch_all_township_cubit.dart';
import '../bloc/post/CityPart/add_city_cubit.dart';
import '../bloc/edit/CountryPart/edit_country_cubit.dart';
import '../bloc/post/CountryPart/request_country_cubit.dart';
import '../bloc/post/add_size_cubit.dart';

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

  //to add deliver company name
  AddDeliveryCubit addDeliveryCubit =
      AddDeliveryCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => addDeliveryCubit);

  //to add product to db
  AddProductCubit addProductCubit =
      AddProductCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => addProductCubit);

  //to add product to shopkeeper request
  AddRequestProductShopKeeperCubit addRequestProductShopKeeperCubit =
      AddRequestProductShopKeeperCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => addRequestProductShopKeeperCubit);

  //get all category
  GetCategoryDetailCubit getCategoryDetailCubit =
      GetCategoryDetailCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => getCategoryDetailCubit);

  //fetch all city
  FetchAllCityCubit fetchAllCityCubit =
      FetchAllCityCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => fetchAllCityCubit);

/*
  //fetch all delivery company name
  FetchAllDeliveryCompanyNameCubit fetchDeliveryNameCubit =
  FetchAllDeliveryCompanyNameCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => fetchDeliveryNameCubit);

*/

  //fetch all township
  FetchAllTownshipCubit fetchAllTownshipCubit =
  FetchAllTownshipCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => fetchAllTownshipCubit);


  //fetch all country
  RequestCountryCubit requestCountryCubit =
      RequestCountryCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => requestCountryCubit);

  //add all city
  AddCityCubit addCityCubit = AddCityCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => addCityCubit);

  //add all township
  AddTownshipCubit addTownshipCubit = AddTownshipCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => addTownshipCubit);

  //get all product
  GetAllProductCubit getAllProductCubit =
      GetAllProductCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => getAllProductCubit);

  /* //get all product by cate id
  FetchAllProductByCateIdCubit fetchAllProductByCateIdCubit =
  FetchAllProductByCateIdCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => fetchAllProductByCateIdCubit);
*/
  //get all size
  GetAllSizeCubit getAllSizeCubit =
      GetAllSizeCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => getAllSizeCubit);

  //to delete category
  DeleteCategoryCubit categoryDeleteCubit = DeleteCategoryCubit(getIt.call());
  getIt.registerLazySingleton(() => categoryDeleteCubit);

  //to delete country
  DeleteCountryCubit deleteCountryCubit = DeleteCountryCubit(getIt.call());
  getIt.registerLazySingleton(() => deleteCountryCubit);

  //to delete city
  DeleteCityCubit deleteCityCubit = DeleteCityCubit(getIt.call());
  getIt.registerLazySingleton(() => deleteCityCubit);

  //to delete product item
  DeleteProductItemCubit productDeleteCubit =
      DeleteProductItemCubit(getIt.call());
  getIt.registerLazySingleton(() => productDeleteCubit);

  //to delete size
  DeleteSizeCubit deleteSizeCubit = DeleteSizeCubit(getIt.call());
  getIt.registerLazySingleton(() => deleteSizeCubit);

  //to update category
  EditCategoryCubit editCategoryCubit = EditCategoryCubit(getIt.call());
  getIt.registerLazySingleton(() => editCategoryCubit);

  //to update country by id
  EditCountryCubit editCountryCubit = EditCountryCubit(getIt.call());
  getIt.registerLazySingleton(() => editCountryCubit);

  //to update city by id
  EditCityCubit editCityCubit = EditCityCubit(getIt.call());
  getIt.registerLazySingleton(() => editCityCubit);

  //to update township by id
  EditTownshipCubit editTownshipCubit = EditTownshipCubit(getIt.call());
  getIt.registerLazySingleton(() => editTownshipCubit);

  //to update product item
  EditProductItemCubit editProductItemCubit =
      EditProductItemCubit(getIt.call());
  getIt.registerLazySingleton(() => editProductItemCubit);

  //to update size
  EditSizeCubit editSizeCubit = EditSizeCubit(getIt.call());
  getIt.registerLazySingleton(() => editSizeCubit);

  //add size to db
  AddSizeCubit addSizeCubit = AddSizeCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => addSizeCubit);
  //for add user role
  AddUserRoleCubit addUserRoleCubit =
      AddUserRoleCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => addUserRoleCubit);

  //to get all user role
  GetAllUserRoleCubit getAllUserRoleCubit =
      GetAllUserRoleCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => getAllUserRoleCubit);

  //to edit  user role
  EditUserRoleCubit editUserRoleCubit =
      EditUserRoleCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => editUserRoleCubit);

  //to delete user role
  DeleteUserRoleCubit deleteUserRoleCubit = DeleteUserRoleCubit(getIt.call());
  getIt.registerLazySingleton(() => deleteUserRoleCubit);
}
