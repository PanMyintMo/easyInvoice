import 'package:easy_invoice/data/api/apiService.dart';
import 'package:easy_invoice/data/responsemodel/AddSizeResponse.dart';
import 'package:easy_invoice/data/responsemodel/CountryPart/CountryResponse.dart';
import 'package:easy_invoice/data/responsemodel/EditProductResponse.dart';
import 'package:easy_invoice/data/responsemodel/Login&RegisterResponse/RegisterResponse.dart';
import 'package:easy_invoice/data/responsemodel/UserResponse.dart';
import 'package:easy_invoice/dataRequestModel/EditProductRequestModel.dart';
import 'package:easy_invoice/dataRequestModel/EditUserRoleRequestModel.dart';
import 'package:easy_invoice/dataRequestModel/FaultyItemPart/AddFaultyItemRequest.dart';
import 'package:easy_invoice/dataRequestModel/UserRequestModel.dart';
import '../../dataRequestModel/AddCategoryRequestModel.dart';
import '../../dataRequestModel/AddProductRequestModel.dart';
import '../../dataRequestModel/AddSizeRequestModel.dart';
import '../../dataRequestModel/CityPart/AddCity.dart';
import '../../dataRequestModel/CityPart/EditCity.dart';
import '../../dataRequestModel/CountryPart/AddCountry.dart';
import '../../dataRequestModel/CountryPart/EditCountry.dart';
import '../../dataRequestModel/DeliveryPart/AddDeliveryCompanyNameRequestModel.dart';
import '../../dataRequestModel/DeliveryPart/AddOrderRequestModel.dart';
import '../../dataRequestModel/DeliveryPart/OrderByDateRequestModel.dart';
import '../../dataRequestModel/DeliveryPart/ProductInvoiceRequest.dart';
import '../../dataRequestModel/EditCategoryModel.dart';
import '../../dataRequestModel/EditSizeModel.dart';
import '../../dataRequestModel/Login&Register/EditCompanyProfileRequestModel.dart';
import '../../dataRequestModel/Login&Register/LoginRequestModel.dart';
import '../../dataRequestModel/Login&Register/RegisterRequestModel.dart';
import '../../dataRequestModel/ShopKeeperPart/EditRequestModel.dart';
import '../../dataRequestModel/ShopKeeperPart/ShopKeeperRequestModel.dart';
import '../../dataRequestModel/TownshipPart/AddTownship.dart';
import '../../dataRequestModel/TownshipPart/EditTownship.dart';
import '../responsemodel/AddCategoryResponseModel.dart';
import '../responsemodel/CityPart/AddCityResponse.dart';
import '../responsemodel/CityPart/Cities.dart';
import '../responsemodel/DeliveryPart/FetchAllDeliveries.dart';
import '../responsemodel/DeliveryPart/FetchAllOrderByDate.dart';
import '../responsemodel/ShopKeeperResponsePart/DeliveredWarehouseRequest.dart';
import '../responsemodel/common/DeleteResponse.dart';
import '../responsemodel/CityPart/EditCityResponse.dart';
import '../responsemodel/CountryPart/EditCountryResponse.dart';
import '../responsemodel/CountryPart/RequestCountryResponse.dart';
import '../responsemodel/DeliveryPart/AddDeliveryResponse.dart';
import '../responsemodel/DeliveryPart/AddOrderResponse.dart';
import '../responsemodel/DeliveryPart/DeliveryManResponse.dart';
import '../responsemodel/DeliveryPart/ProductInvoiceResponse.dart';
import '../responsemodel/EditUserRoleResponse.dart';
import '../responsemodel/FaultyItemPart/AddFaultyItemResponse.dart';
import '../responsemodel/FaultyItemPart/AllFaultyItems.dart';
import '../responsemodel/GetAllPagnitaionDataResponse.dart';
import '../responsemodel/Login&RegisterResponse/EditCompanyProfileResponse.dart';
import '../responsemodel/Login&RegisterResponse/LoginResponse.dart';
import '../responsemodel/Login&RegisterResponse/CompanyProfileResponse.dart';
import '../responsemodel/MainPagePart/MainPageResponse.dart';
import '../responsemodel/ProductResponse.dart';
import '../responsemodel/ShopKeeperResponsePart/EditShopKeeperResponse.dart';
import '../responsemodel/ShopKeeperResponsePart/ShopKeeperRequestResponse.dart';
import '../responsemodel/ShopKeeperResponsePart/ShopKeeperResponse.dart';
import '../responsemodel/ShopKeeperResponsePart/ShopProductListResponse.dart';
import '../responsemodel/TownshipsPart/AddTownshipResponse.dart';
import '../responsemodel/TownshipsPart/AllTownshipResponse.dart';
import '../responsemodel/TownshipsPart/EditTownshipResponse.dart';
import '../responsemodel/common/UpdateResponse.dart';
import '../responsemodel/UserRoleResponse.dart';
import '../responsemodel/WarehousePart/WarehouseResponse.dart';
import '../responsemodel/common/ProductListItemResponse.dart';

class UserRepository {
  final ApiService _apiService;

  UserRepository() : _apiService = ApiService();

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
  Future<AddOrderResponse> addOrder(
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
  Future<List<OrderFilterItem>> allOrderByDate(
      OrderByDateRequest orderByDateRequest) async {
    try {
      final response = await _apiService.fetchAllOrderByDate(orderByDateRequest);
      return response.data.data;
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
  Future<List<PaginationItem>> getCategory() async {
    try {
      final response = await _apiService.getAllCategories();
      return response.data.data;
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
  Future<List<DeliveriesItem>> fetchAllDelivery() async {
    try {
      final response = await _apiService.fetchAllDelivery();
      return response.data.data;
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }


  //fetch all faulty items
  Future<List<FaultyItemData>> fetchAllFaultyItem() async {
    try {
      final response = await _apiService.fetchAllFaultyItem();
      return response.data.data;
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
  Future<List<City>> fetchCity() async {
    try {
      final response = await _apiService.cities();
      return response.data.cities;
    } catch (error) {
      throw Exception('Failed to fetch city: $error');
    }
  }

  //fetch townships from db
  Future<List<Township>> fetchTownships() async {
    try {
      final response = await _apiService.townships();
      return response.data.data;
    } catch (error) {
      throw Exception('Failed to fetch township: $error');
    }
  }

  //fetch country from db
  Future<List<Country>> fetchCountry() async {
    try {
      final response = await _apiService.country();
      return response.data.data;
    } catch (error) {
      throw Exception('Failed to fetch country: $error');
    }
  }

  //fetch all products
  Future<List<ProductListItem>> fetchAllProduct() async {
    try {
      final response = await _apiService.fetchAllProducts();
      return response.data.data;
    } catch (error) {
      throw Exception('Failed to get products: $error');
    }
  }

  //fetch all sizes
  Future<List<PaginationItem>> getSizes() async {
    try {
      final response = await _apiService.getAllSizes();
      return response.data.data;
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
      final response = await _apiService.AddDelivery(addDeliveryRequestModel);
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
}
