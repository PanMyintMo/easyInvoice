import 'package:easy_invoice/bloc/delete/CityPart/delete_street_cubit.dart';
import 'package:easy_invoice/bloc/delete/CityPart/delete_ward_cubit.dart';
import 'package:easy_invoice/bloc/delete/ShopKeeperPart/delete_shop_keeper_product_request_cubit.dart';
import 'package:easy_invoice/bloc/delete/delete_category_cubit.dart';
import 'package:easy_invoice/bloc/delete/delete_size_cubit.dart';
import 'package:easy_invoice/bloc/edit/CityPart/edit_order_detail_cubit.dart';
import 'package:easy_invoice/bloc/edit/FaultyPart/update_faulty_cubit.dart';
import 'package:easy_invoice/bloc/edit/edit_category_cubit.dart';
import 'package:easy_invoice/bloc/edit/edit_product_item_cubit.dart';
import 'package:easy_invoice/bloc/edit/edit_size_cubit.dart';
import 'package:easy_invoice/bloc/edit/edit_user_role_cubit.dart';
import 'package:easy_invoice/bloc/edit/statusChange/delivery_man_status_cubit.dart';
import 'package:easy_invoice/bloc/edit/statusChange/warehouse_manager_status_cubit.dart';
import 'package:easy_invoice/bloc/get/CityPart/fetch_all_city_cubit.dart';
import 'package:easy_invoice/bloc/get/CityPart/fetch_all_street_cubit.dart';
import 'package:easy_invoice/bloc/get/MainPagePart/order_filter_by_date_cubit.dart';
import 'package:easy_invoice/bloc/get/ProductPart/get_all_product_cubit.dart';
import 'package:easy_invoice/bloc/get/ShopKeeperPart/shop_product_list_cubit.dart';
import 'package:easy_invoice/bloc/get/SizePart/get_all_size_cubit.dart';
import 'package:easy_invoice/bloc/get/UserRolePart/get_all_user_role_cubit.dart';
import 'package:easy_invoice/bloc/get/CategoryPart/get_category_detail_cubit.dart';
import 'package:easy_invoice/bloc/post/CityPart/add_street_cubit.dart';
import 'package:easy_invoice/bloc/post/DeliveryPart/add_delivery_cubit.dart';
import 'package:easy_invoice/bloc/post/DeliveryPart/change_order_status_cubit.dart';
import 'package:easy_invoice/bloc/post/DeliveryPart/fetch_order_by_date_cubit.dart';
import 'package:easy_invoice/bloc/post/FaultyItemPart/add_request_faulty_item_cubit.dart';
import 'package:easy_invoice/bloc/post/Login&Register/edit_company_profile_cubit.dart';
import 'package:easy_invoice/bloc/post/ShopKeeperPart/add_request_product_shop_keeper_cubit.dart';
import 'package:easy_invoice/bloc/post/TownshipPart/add_township_cubit.dart';
import 'package:easy_invoice/bloc/post/CategoryPart/add_category_cubit.dart';
import 'package:easy_invoice/bloc/post/ProductPart/add_product_cubit.dart';
import 'package:easy_invoice/bloc/post/Login&Register/sign_in_cubit.dart';
import 'package:easy_invoice/bloc/post/Login&Register/sign_up_cubit.dart';
import 'package:easy_invoice/bloc/post/add_user_role_cubit.dart';
import 'package:easy_invoice/bloc/post/product_invoice_cubit.dart';
import 'package:easy_invoice/data/api/apiService.dart';
import 'package:easy_invoice/data/userRepository/UserRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../bloc/delete/CityPart/delete_city_cubit.dart';
import '../bloc/delete/CountryPart/delete_country_cubit.dart';
import '../bloc/delete/DeliveryPart/delete_delivery_cubit.dart';
import '../bloc/delete/FaultyPart/delete_faulty_item_cubit.dart';
import '../bloc/delete/delete_product_item_cubit.dart';
import '../bloc/delete/delete_user_role_cubit.dart';
import '../bloc/edit/CityPart/edit_city_cubit.dart';
import '../bloc/edit/CityPart/edit_ward_cubit.dart';
import '../bloc/edit/TownshipPart/edit_township_cubit.dart';
import '../bloc/edit/statusChange/shopkeeper_status_cubit.dart';
import '../bloc/get/CityPart/fetch_all_ward_cubit.dart';
import '../bloc/get/CompanyProfile/company_profile_cubit.dart';
import '../bloc/get/DeliveryManPart/fetch_all_delivery_cubit.dart';
import '../bloc/get/DeliveryManPart/fetch_all_order_detail_cubit.dart';
import '../bloc/get/DeliveryManPart/fetch_all_warehouse_request_cubit.dart';
import '../bloc/get/FaultyItemPart/fetch_all_faulty_item_cubit.dart';
import '../bloc/get/ShopKeeperPart/deliver_warehouse_request_cubit.dart';
import '../bloc/get/ShopKeeperPart/shop_keeper_request_cubit.dart';
import '../bloc/get/TownshipPart/fetch_all_township_cubit.dart';
import '../bloc/get/WarehousePart/warehouse_product_list_cubit.dart';
import '../bloc/post/CityPart/add_city_cubit.dart';
import '../bloc/edit/CountryPart/edit_country_cubit.dart';
import '../bloc/post/CountryPart/request_country_cubit.dart';
import '../bloc/post/DeliveryPart/add_order_cubit.dart';
import '../bloc/post/DeliveryPart/deli_company_info_cubit.dart';
import '../bloc/post/ShopKeeperPart/update_shop_keeper_cubit.dart';
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

  //for edit company profile
  EditCompanyProfileCubit editCompanyProfileCubit =
      EditCompanyProfileCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => editCompanyProfileCubit);

  //for company profile
  CompanyProfileCubit companyProfileCubit =
      CompanyProfileCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => companyProfileCubit);

  //to add category to db
  AddCategoryCubit addCategoryCubit =
      AddCategoryCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => addCategoryCubit);

  //to add deliver company name
  AddDeliveryCubit addDeliveryCubit =
      AddDeliveryCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => addDeliveryCubit);

  //to add product to
  AddProductCubit addProductCubit =
      AddProductCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => addProductCubit);

  //to add request faulty item
  AddRequestFaultyItemCubit addRequestFaultyItemCubit =
      AddRequestFaultyItemCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => addRequestFaultyItemCubit);

  //to add product to shopkeeper request
  AddRequestProductShopKeeperCubit addRequestProductShopKeeperCubit =
      AddRequestProductShopKeeperCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => addRequestProductShopKeeperCubit);

  //fetch all category
  GetCategoryDetailCubit getCategoryDetailCubit =
      GetCategoryDetailCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => getCategoryDetailCubit);

  //fetch all order by date
  FetchOrderByDateCubit fetchOrderByDateCubit =
      FetchOrderByDateCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => fetchOrderByDateCubit);



  //fetch all order details
  FetchAllOrderDetailCubit fetchAllOrderDetailCubit =
  FetchAllOrderDetailCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => fetchAllOrderDetailCubit);

//change order status
  ChangeOrderStatusCubit changeOrderStatusCubit =
  ChangeOrderStatusCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => changeOrderStatusCubit);


  //edit order details
  EditOrderDetailCubit editOrderDetailCubit =
  EditOrderDetailCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => editOrderDetailCubit);


  //Delivered Warehouse Request
  DeliverWarehouseRequestCubit deliveryWarehouseRequestCubit =
      DeliverWarehouseRequestCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => deliveryWarehouseRequestCubit);

  //fetch all faulty items
  FetchAllFaultyItemCubit fetchAllFaultyItemCubit =
      FetchAllFaultyItemCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => fetchAllFaultyItemCubit);


  //deli company info
  DeliCompanyInfoCubit deliCompanyInfoCubit =
  DeliCompanyInfoCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => deliCompanyInfoCubit);


  //fetch all delivery
  FetchAllDeliveryCubit fetchAllDeliveryCubit =
      FetchAllDeliveryCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => fetchAllDeliveryCubit);

  //fetch all warehouse request for deliver man
  FetchAllWarehouseRequestCubit fetchAllWarehouseRequestCubit =
      FetchAllWarehouseRequestCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => fetchAllWarehouseRequestCubit);

  //update shopkeeper
  UpdateShopKeeperCubit updateShopKeeperCubit =
      UpdateShopKeeperCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => updateShopKeeperCubit);

  //fetch all city
  FetchAllCityCubit fetchAllCityCubit =
      FetchAllCityCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => fetchAllCityCubit);

  //fetch all township
  FetchAllTownshipCubit fetchAllTownshipCubit =
      FetchAllTownshipCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => fetchAllTownshipCubit);

  //fetch all ward
  FetchAllWardCubit fetchAllWardCubit =
      FetchAllWardCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => fetchAllWardCubit);

  //fetch all street
  FetchAllStreetCubit fetchAllStreetCubit =
      FetchAllStreetCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => fetchAllStreetCubit);
  //fetch all country
  RequestCountryCubit requestCountryCubit =
      RequestCountryCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => requestCountryCubit);

  //add all city
  AddCityCubit addCityCubit = AddCityCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => addCityCubit);

  //add all township
  AddTownshipCubit addTownshipCubit =
      AddTownshipCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => addTownshipCubit);

  //get all product
  GetAllProductCubit getAllProductCubit =
      GetAllProductCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => getAllProductCubit);

  //get all size
  GetAllSizeCubit getAllSizeCubit =
      GetAllSizeCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => getAllSizeCubit);

  //to warehouse manager status change
  WarehouseManagerStatusCubit warehouseManagerStatusCubit = WarehouseManagerStatusCubit(getIt.call());
  getIt.registerLazySingleton(() => warehouseManagerStatusCubit);

//to delivery man status change
  DeliveryManStatusCubit deliveryManStatusCubit = DeliveryManStatusCubit(getIt.call());
  getIt.registerLazySingleton(() => deliveryManStatusCubit);


  //to shopkeeper status change
  ShopkeeperStatusCubit shopkeeperStatusCubit = ShopkeeperStatusCubit(getIt.call());
  getIt.registerLazySingleton(() => shopkeeperStatusCubit);

  //to delete category
  DeleteCategoryCubit categoryDeleteCubit = DeleteCategoryCubit(getIt.call());
  getIt.registerLazySingleton(() => categoryDeleteCubit);

  //to delete country
  DeleteCountryCubit deleteCountryCubit = DeleteCountryCubit(getIt.call());
  getIt.registerLazySingleton(() => deleteCountryCubit);

  //to delete faulty item
  DeleteFaultyItemCubit deleteFaultyItemCubit =
      DeleteFaultyItemCubit(getIt.call());
  getIt.registerLazySingleton(() => deleteFaultyItemCubit);

  //to delete delivery
  DeleteDeliveryCubit deleteDeliveryCubit = DeleteDeliveryCubit(getIt.call());
  getIt.registerLazySingleton(() => deleteDeliveryCubit);

  //to delete city
  DeleteCityCubit deleteCityCubit = DeleteCityCubit(getIt.call());
  getIt.registerLazySingleton(() => deleteCityCubit);

  //to delete ward
  DeleteWardCubit deleteWardCubit = DeleteWardCubit(getIt.call());
  getIt.registerLazySingleton(() => deleteWardCubit);

  //to delete street
  DeleteStreetCubit deleteStreetCubit = DeleteStreetCubit(getIt.call());
  getIt.registerLazySingleton(() => deleteStreetCubit);

  //to delete shopkeeper request product
  DeleteShopKeeperProductRequestCubit deleteShopKeeperProductRequestCubit =
      DeleteShopKeeperProductRequestCubit(getIt.call());
  getIt.registerLazySingleton(() => deleteShopKeeperProductRequestCubit);

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

  //to update faulty
  UpdateFaultyCubit editCubit = UpdateFaultyCubit(getIt.call());
  getIt.registerLazySingleton(() => editCubit);

  //to update township by id
  EditTownshipCubit editTownshipCubit = EditTownshipCubit(getIt.call());
  getIt.registerLazySingleton(() => editTownshipCubit);

  //to update product item
  EditProductItemCubit editProductItemCubit =
      EditProductItemCubit(getIt.call());
  getIt.registerLazySingleton(() => editProductItemCubit);

  //to fetch shop all product list item
  ShopProductListCubit shopProductListCubit =
      ShopProductListCubit(getIt.call());
  getIt.registerLazySingleton(() => shopProductListCubit);

  //fetch warehouse product list
  WarehouseProductListCubit warehouseProductListCubit =
      WarehouseProductListCubit(getIt.call());
  getIt.registerLazySingleton(() => warehouseProductListCubit);

  //to update size
  EditSizeCubit editSizeCubit = EditSizeCubit(getIt.call());
  getIt.registerLazySingleton(() => editSizeCubit);

//to update ward
  EditWardCubit editWardCubit = EditWardCubit(getIt.call());
  getIt.registerLazySingleton(() => editWardCubit);

  //shopkeeper request list
  ShopKeeperRequestCubit shopKeeperRequestCubit =
      ShopKeeperRequestCubit(getIt.call());
  getIt.registerLazySingleton(() => shopKeeperRequestCubit);

  //fetch order filter by date
  OrderFilterByDateCubit orderFilterByDate =
      OrderFilterByDateCubit(getIt.call());
  getIt.registerLazySingleton(() => orderFilterByDate);

  //add size to db
  AddSizeCubit addSizeCubit = AddSizeCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => addSizeCubit);
  //for add user role
  AddUserRoleCubit addUserRoleCubit =
      AddUserRoleCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => addUserRoleCubit);

  //to add order
  AddOrderCubit addOrderCubit = AddOrderCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => addOrderCubit);

  //product invoice
  ProductInvoiceCubit productInvoice =
      ProductInvoiceCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => productInvoice);

  //to get all user role
  GetAllUserRoleCubit getAllUserRoleCubit =
      GetAllUserRoleCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => getAllUserRoleCubit);

  // //to get all ward by township id
  // FetchWardByTownshipCubit fetchWardByTownshipCubit =
  // FetchWardByTownshipCubit(getIt.get<UserRepository>());
  // getIt.registerLazySingleton(() => fetchWardByTownshipCubit);

  //to edit  user role
  EditUserRoleCubit editUserRoleCubit =
      EditUserRoleCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => editUserRoleCubit);

  //to add street
  AddStreetCubit addStreetCubit = AddStreetCubit(getIt.get<UserRepository>());
  getIt.registerLazySingleton(() => addStreetCubit);

  //to delete user role
  DeleteUserRoleCubit deleteUserRoleCubit = DeleteUserRoleCubit(getIt.call());
  getIt.registerLazySingleton(() => deleteUserRoleCubit);
}
