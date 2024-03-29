import 'package:easy_invoice/data/api/apiService.dart';
import 'package:easy_invoice/data/responseModel/AddSizeResponse.dart';
import 'package:easy_invoice/data/responseModel/CityPart/AddStreetResponse.dart';
import 'package:easy_invoice/data/responseModel/CityPart/Street.dart';
import 'package:easy_invoice/data/responseModel/CountryPart/CountryResponse.dart';
import 'package:easy_invoice/data/responseModel/EditProductResponse.dart';
import 'package:easy_invoice/data/responseModel/GetAllPaganizationDataResponse.dart';
import 'package:easy_invoice/data/responseModel/UserResponse.dart';
import 'package:easy_invoice/dataRequestModel/CityPart/AddStreetRequestModel.dart';
import 'package:easy_invoice/dataRequestModel/EditProductRequestModel.dart';
import 'package:easy_invoice/dataRequestModel/EditUserRoleRequestModel.dart';
import 'package:easy_invoice/dataRequestModel/FaultyItemPart/AddFaultyItemRequest.dart';
import 'package:easy_invoice/dataRequestModel/UserRequestModel.dart';
import '../../dataRequestModel/AddCategoryRequestModel.dart';
import '../../dataRequestModel/AddProductRequestModel.dart';
import '../../dataRequestModel/AddSizeRequestModel.dart';
import '../../dataRequestModel/CityPart/AddCity.dart';
import '../../dataRequestModel/CityPart/AddWardRequestModel.dart';
import '../../dataRequestModel/CityPart/EditCity.dart';
import '../../dataRequestModel/CountryPart/AddCountry.dart';
import '../../dataRequestModel/CountryPart/EditCountry.dart';
import '../../dataRequestModel/DeliveryPart/AddDeliveryCompanyInfoRequestModel.dart';
import '../../dataRequestModel/DeliveryPart/AddDeliveryCompanyNameRequestModel.dart';
import '../../dataRequestModel/DeliveryPart/AddOrderRequestModel.dart';
import '../../dataRequestModel/DeliveryPart/ChangeOrderStatusRequestModel.dart';
import '../../dataRequestModel/DeliveryPart/EditOrderDetailRequestModel.dart';
import '../../dataRequestModel/DeliveryPart/OrderByDateRequestModel.dart';
import '../../dataRequestModel/DeliveryPart/ProductInvoiceRequest.dart';
import '../../dataRequestModel/DeliveryPart/UpdateDeliveryRequestModel.dart';
import '../../dataRequestModel/EditCategoryModel.dart';
import '../../dataRequestModel/EditSizeModel.dart';
import '../../dataRequestModel/Login&Register/EditCompanyProfileRequestModel.dart';
import '../../dataRequestModel/Login&Register/LoginRequestModel.dart';
import '../../dataRequestModel/Login&Register/RegisterRequestModel.dart';
import '../../dataRequestModel/ShopKeeperPart/EditRequestModel.dart';
import '../../dataRequestModel/ShopKeeperPart/ShopKeeperRequestModel.dart';
import '../../dataRequestModel/TownshipPart/AddTownship.dart';
import '../../dataRequestModel/TownshipPart/EditTownship.dart';
import '../../widget/ProductInvoicePart/InvoiceResponse/Invoice.dart';
import '../api/ConnectivityService.dart';
import '../responseModel/AddCategoryResponseModel.dart';
import '../responseModel/CityPart/AddCityResponse.dart';
import '../responseModel/CityPart/AddWardResponse.dart';
import '../responseModel/CityPart/Cities.dart';
import '../responseModel/CityPart/EditCityResponse.dart';
import '../responseModel/CityPart/EditWardResponse.dart';
import '../responseModel/CountryPart/EditCountryResponse.dart';
import '../responseModel/CountryPart/RequestCountryResponse.dart';
import '../responseModel/DeliveryPart/AddDeliveryResponse.dart';
import '../responseModel/DeliveryPart/AddOrderResponse.dart';
import '../responseModel/DeliveryPart/DeliveryCompanyInfoResponse.dart';
import '../responseModel/DeliveryPart/DeliveryManResponse.dart';
import '../responseModel/DeliveryPart/FetchAllDeliveries.dart';
import '../responseModel/DeliveryPart/OrderDetailResponse.dart';
import '../responseModel/DeliveryPart/ProductInvoiceResponse.dart';
import '../responseModel/EditUserRoleResponse.dart';
import '../responseModel/FaultyItemPart/AddFaultyItemResponse.dart';
import '../responseModel/FaultyItemPart/AllFaultyItems.dart';
import '../responseModel/GeneralMainResponse/CompanyProfileResponse.dart';
import '../responseModel/GeneralMainResponse/EditCompanyProfileResponse.dart';
import '../responseModel/GeneralMainResponse/LoginResponse.dart';
import '../responseModel/GeneralMainResponse/RegisterResponse.dart';
import '../responseModel/MainPagePart/MainPageResponse.dart';
import '../responseModel/ProductResponse.dart';
import '../responseModel/ShopKeeperResponsePart/DeliveredWarehouseRequest.dart';
import '../responseModel/ShopKeeperResponsePart/EditShopKeeperResponse.dart';
import '../responseModel/ShopKeeperResponsePart/ShopKeeperRequestResponse.dart';
import '../responseModel/ShopKeeperResponsePart/ShopKeeperResponse.dart';
import '../responseModel/ShopKeeperResponsePart/ShopProductListResponse.dart';
import '../responseModel/TownshipsPart/AddTownshipResponse.dart';
import '../responseModel/TownshipsPart/AllTownshipResponse.dart';
import '../responseModel/TownshipsPart/EditTownshipResponse.dart';
import '../responseModel/UserRoleResponse.dart';
import '../responseModel/WarehousePart/WarehouseResponse.dart';
import '../responseModel/common/DeleteResponse.dart';
import '../responseModel/common/ProductListItemResponse.dart';
import '../responseModel/common/UpdateResponse.dart';
import '../responseModel/common/WardResponse.dart';


class UserRepository {
  final ApiService _apiService;

  UserRepository() : _apiService = ApiService(ConnectivityService());

  //For Register
  Future<RegisterResponse> signUp(
      RegisterRequestModel registerRequestModel) async {
    try {
      final response = await _apiService.signUp(registerRequestModel);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //For Login
  Future<LoginResponse> signIn(LoginRequestModel loginRequestModel) async {
    try {
      final response = await _apiService.signIn(loginRequestModel);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //For company profile
  Future<CompanyProfileResponse> companyProfile() async {
    try {
      final response = await _apiService.companyProfile();
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //For edit company profile
  Future<EditCompanyProfileResponse> editCompanyProfile(
      EditCompanyProfileRequestModel editProfileRequestModel, int id) async {
    try {
      final response =
          await _apiService.editCompanyProfile(editProfileRequestModel, id);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //For edit delivery
  Future<DeliCompanyInfoResponse> updateDeliveryById(
    int id,UpdateDeliveryRequestModel updateDeliveryRequestModel) async {
    try {
      final response =
      await _apiService.updateDeliveryById(id,updateDeliveryRequestModel);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //request for add  country
  Future<RequestCountryResponse> addCountry(AddCountry addCountry) async {
    try {
      final response = await _apiService.requestCountry(addCountry);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //For add order
  Future<OrderResponse> addOrder(
      AddOrderRequestModel addOrderRequest) async {
    try {
      final response = await _apiService.addOrder(addOrderRequest);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //For warehouse product list
  Future<WarehouseResponse> warehouse() async {
    try {
      final response = await _apiService.fetchWarehouseProductList();
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //For main page order filter
  Future<OrderApiResponse?> fetchDataForDifferentFilterTypes(String filterType) async {
    try {
      OrderApiResponse? responseData;
      if (filterType == "All Orders") {
        responseData = await _apiService.orderFilter("default");
      } else if (filterType == "Daily Orders") {
        responseData = await _apiService.orderFilter("daily");
      } else if (filterType == "Weekly Orders") {
        responseData = await _apiService.orderFilter("weekly");
      } else if (filterType == "Monthly Orders") {
        responseData = await _apiService.orderFilter("monthly");
      } else if (filterType == "Yearly Orders") {
        responseData = await _apiService.orderFilter("yearly");
      } else if (filterType == "lastmonth") {
        responseData = await _apiService.orderFilter("lastmonth");
      }
      return responseData;

    } catch (error) {
      rethrow;
    }
  }

  //product invoice
  Future<List<InvoiceData>> productInvoice(
      ProductInvoiceRequest productInvoiceRequest) async {
    try {
      final response = await _apiService.productInvoice(productInvoiceRequest);
      return response.data;
    } catch (error) {
      rethrow;
    }
  }

  //fetch all order by date
  Future<List<OrderDatas>?> allOrderByDate(
      OrderByDateRequest orderByDateRequest) async {
    try {
      final response = await _apiService.fetchAllOrderByDate(orderByDateRequest);
      return response.data;
    } catch (error) {
      rethrow;
    }
  }

  //request for add  city
  Future<AddCityResponse> addCity(AddCity addCity) async {
    try {
      final response = await _apiService.requestCity(addCity);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //change Order Status
  Future<DeleteResponse> changeOrderStatus(ChangeOrderStatusRequestModel changeOrderStatusRequestModel) async {
    try {
      final response = await _apiService.changeOrderStatus(changeOrderStatusRequestModel);
      return response;
    } catch (error) {
      rethrow;
    }
  }


  //deli company info
  Future<DeliCompanyInfoResponse> deliCompanyInfo(AddDeliCompanyInfoRequest addDeliCompanyInfoRequest) async {
    try {
      final response = await _apiService.deliCompanyInfo(addDeliCompanyInfoRequest);
      return response;
    } catch (error) {
      rethrow;
    }
  }


  //fetch order detail
  Future<OrderDetailResponse> fetchOrderDetail(int id) async {
    try {
      final response = await _apiService.fetchOrderDetail(id);
      return response;
    } catch (error) {
      rethrow;
    }
  }

//edit order detail
  Future<OrderResponse> editOrderDetail(int id,EditOrderDetailRequestModel editOrderDetailRequestModel) async {
    try {
      final response = await _apiService.editOrderDetail(id,editOrderDetailRequestModel);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //Invoice
  Future<Invoice> generateInvoice() async {
    try {
      final response = await _apiService.generate();
      return response;
    } catch (error) {
      rethrow;
    }
  }


  //request for add  township
  Future<AddTownshipResponse> addTownship(AddTownship addTownship) async {
    try {
      final response = await _apiService.requestTownship(addTownship);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //for add category
  Future<AddCategoryResponse> addCategory(
      AddCategoryRequestModel addCategoryRequestModel) async {
    try {
      final response = await _apiService.addCategory(addCategoryRequestModel);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //for add shopkeeper request product
  Future<AddShopKeeperResponse> addShopKeeperRequestProduct(
      ShopKeeperRequestModel shopKeeperRequestModel) async {
    try {
      final response =
          await _apiService.addShopKeeperRequestProduct(shopKeeperRequestModel);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //update shopkeeper
  Future<EditResponse> updateShopKeeper(
      EditRequestModel editShopKeeperRequestModel,int id) async {
    try {
      final response =
      await _apiService.editShopKeeper(editShopKeeperRequestModel,id);
      return response;
    } catch (error) {
      rethrow;
    }
  }


  //update faulty item
  Future<EditResponse> updateFaulty(
      EditRequestModel editRequestModel,int id) async {
    try {
      final response =
      await _apiService.editFaulty(editRequestModel,id);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //for add product
  Future<ProductResponse> addProduct(
      AddProductRequestModel addProductRequestModel) async {
    try {
      final response = await _apiService.addProduct(addProductRequestModel);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //For get all user role
  Future<UserRoleResponse> getAllUserRole() async {
    try {
      final response = await _apiService.getAllUserRole();
      return response;
    } catch (error) {
      rethrow;
    }
  }

  // to edit all user role
  Future<EditUserRoleResponse> editUserRole(
      EditUserRoleRequestModel editUserRoleRequestModel, int id) async {
    try {
      final response =
          await _apiService.editUserRole(editUserRoleRequestModel, id);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //for size add to db
  Future<AddSizeResponse> addSize(
      AddSizeRequestModel addSizeRequestModel) async {
    try {
      final response = await _apiService.addSize(addSizeRequestModel);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //fetch all categories from db
  Future<List<PaganizationItem>?> getCategory() async {
    try {
      final response = await _apiService.getAllCategories();
      return response.data;
    } catch (error) {
      throw Exception('Failed to fetch category: $error');
    }
  }

  //Receive product form delivery man
  Future<List<DeliveryWarehouseItem>> deliverWarehouseRequest() async {
    try {
      final response = await _apiService.deliverWarehouseRequest();
      return response.data.data;
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }

  //fetch all deliveries
  Future<List<DeliveriesItem>?> fetchAllDelivery() async {
    try {
      final response = await _apiService.fetchAllDelivery();
      return response.data;
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }


  //fetch all faulty items
  Future<List<FaultyItemData>?> fetchAllFaultyItem() async {
    try {
      final response = await _apiService.fetchAllFaultyItem();
      return response.data;
    } catch (error) {
      throw Exception('Failed to fetch faulty items: $error');
    }
  }

  //fetch all shop product list from db
  Future<List<ShopProductItem>> fetchAllShopProductList() async {
    try {
      final response = await _apiService.shopProductList();
      return response.data.data;
    } catch (error) {
      throw Exception('Failed to fetch shop product list: $error');
    }
  }

  //fetch all warehouse request for delivery man
  Future<List<DeliveryItemData>> fetchAllWarehouseRequest() async {
    try {
      final response = await _apiService.fetchAllWarehouseRequest();
      return response.data.data;
    } catch (error) {
      throw Exception(
          'Failed to fetch warehouse request items for delivery man: $error');
    }
  }

  //fetch city from db
  Future<List<City>?> fetchCity() async {
    try {
      final response = await _apiService.cities();
      return response.data;
    } catch (error) {
      throw Exception('Failed to fetch city: $error');
    }
  }

  //fetch ward from db
  Future<List<Ward>?> fetchWard() async {
    try {
      final response = await _apiService.wards();
      return response.data;
    } catch (error) {
      throw Exception('Failed to fetch ward: $error');
    }
  }

  //fetch street from db
  Future<List<Street>> fetchStreet() async {
    try {
      final response = await _apiService.streets();
      return response.data;
    } catch (error) {
      throw Exception('Failed to fetch street: $error');
    }
  }

  //fetch townships from db
  Future<List<Township>?> fetchTownships() async {
    try {
      final response = await _apiService.townships();
      return response.data;
    } catch (error) {
      throw Exception('Failed to fetch township: $error');
    }
  }

  //fetch country from db
  Future<List<Country>?> fetchCountry() async {
    try {
      final response = await _apiService.country();
      return response.data;
    } catch (error) {
      throw Exception('Failed to fetch country: $error');
    }
  }

  //fetch all products
  Future<List<ProductListItem>?> fetchAllProduct() async {
    try {
      final response = await _apiService.fetchAllProducts();
      return response.data;
    } catch (error) {
      throw Exception('Failed to get products: $error');
    }
  }

  //fetch all sizes
  Future<List<PaganizationItem>?> getSizes() async {
    try {
      final response = await _apiService.getAllSizes();
      return response.data;
    } catch (error) {
      rethrow;
    }
  }

  //warehouse manager status change by id

  Future<DeleteResponse> warehouseManagerStatus(int id) async {
    try {
      final response = await _apiService.warehouseManagerStatus(id);
      return response;
    } catch (error) {
      rethrow;
    }
  }
  //delivery man status change by id

  Future<DeleteResponse> deliveryManStatus(int id) async {
    try {
      final response = await _apiService.deliveryManStatus(id);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //shopkeeper status change by id

  Future<DeleteResponse> shopkeeperStatus(int id) async {
    try {
      final response = await _apiService.shopKeeperStatus(id);
      return response;
    } catch (error) {
      rethrow;
    }
  }

//to delete category by id

  Future<DeleteResponse> deleteCategory(int id) async {
    try {
      final response = await _apiService.deleteCategory(id);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //to delete faulty item by id

  Future<DeleteResponse> deleteFaultyItem(int id) async {
    try {
      final response = await _apiService.deleteFaulty(id);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //to delete country by id
  Future<DeleteResponse> deleteCountry(int id) async {
    try {
      final response = await _apiService.deleteCountry(id);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //to delete delivery by id
  Future<DeleteResponse> deleteDelivery(int id) async {
    try {
      final response = await _apiService.deleteDelivery(id);
      return response;
    } catch (error) {
      rethrow;
    }
  }


  //to delete city by id
  Future<DeleteResponse> deleteCity(int id) async {
    try {
      final response = await _apiService.deleteCity(id);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //to delete street by id
  Future<DeleteResponse> deleteStreet(int id) async {
    try {
      final response = await _apiService.deleteStreet(id);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //to delete ward by id
  Future<DeleteResponse> deleteWard(int id) async {
    try {
      final response = await _apiService.deleteWard(id);
      return response;
    } catch (error) {
      rethrow;
    }
  }
  //to delete shopkeeper product request by id
  Future<DeleteResponse> deleteShopKeeperRequestProduct(int id) async {
    try {
      final response = await _apiService.deleteShopKeeperRequestProduct(id);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //to delete township by id
  Future<DeleteResponse> deleteTownship(int id) async {
    try {
      final response = await _apiService.deleteTownship(id);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //to add delivery company

  Future<AddDeliveryResponse> addDelivery(
      AddDeliveryRequestModel addDeliveryRequestModel) async {
    try {
      final response = await _apiService.addDelivery(addDeliveryRequestModel);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //to add request faulty Item
  Future<AddFaultyItemResponse> addRequestFaultyItem(
      AddFaultyItemRequest addFaultyItemRequest) async {
    try {
      final response =
          await _apiService.addRequestFaultyItem(addFaultyItemRequest);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //shopkeeper request list
  Future<ShopKeeperRequestResponse> shopKeeperRequestList() async {
    try {
      final response = await _apiService.shopKeeperRequestList();
      return response;
    } catch (e) {
      rethrow;
    }
  }
//to delete product item by id
  Future<DeleteResponse> deleteProductItem(int id) async {
    try {
      final response = await _apiService.deleteProductItem(id);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //to delete user role by id

  Future<DeleteResponse> deleteUserRole(int id) async {
    try {
      final response = await _apiService.deleteUserRole(id);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //to delete size by id

  Future<DeleteResponse> deleteSize(int id) async {
    try {
      final response = await _apiService.deleteSize(id);
      return response;
    } catch (error) {
      rethrow;
    }
  }

// update category by id

  Future<UpdateResponse> updateCategory(
      EditCategory editCategory, int id) async {
    try {
      final response = await _apiService.updateCategory(editCategory, id);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  // update country by id
  Future<EditCountryResponse> updateCountry(
      int id, EditCountry editCountry) async {
    try {
      final response = await _apiService.editCountry(id, editCountry);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  // update city by id
  Future<EditCityResponse> updateCity(int id, EditCity editCity) async {
    try {
      final response = await _apiService.editCity(id, editCity);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  // update ward by id
  Future<EditWardResponse> updateWard(int id, AddWardRequestModel updateWardRequestModel) async {
    try {
      final response = await _apiService.editWard(id, updateWardRequestModel);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  // update township by id
  Future<EditTownshipResponse> updateTownship(
      int id, EditTownship editTownship) async {
    try {
      final response = await _apiService.editTownship(id, editTownship);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  // update product by id
  Future<EditProductResponse> updateProductItem(
      EditProductRequestModel editProductRequestModel, int id) async {
    try {
      final response =
          await _apiService.updateProductItem(editProductRequestModel, id);
      return response;
    } catch (error) {
      rethrow;
    }
  }

// update size by id

  Future<UpdateResponse> updateSize(EditSize editSize, int id) async {
    try {
      final response = await _apiService.updateSize(editSize, id);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  // divide user
  Future<UserResponse> user(UserRequestModel userRequestModel) async {
    try {
      final response = await _apiService.user(userRequestModel);
      return response;
    } catch (error) {
      rethrow;
    }
  }



  // add ward
  Future<AddWardResponse> addWard(AddWardRequestModel addWardRequestModel) async {
    try {
      final response = await _apiService.addWard(addWardRequestModel);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  // add street
  Future<AddStreetResponse> addStreet(AddStreetRequestModel addStreetRequestModel) async {
    try {
      final response = await _apiService.addStreet(addStreetRequestModel);
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
