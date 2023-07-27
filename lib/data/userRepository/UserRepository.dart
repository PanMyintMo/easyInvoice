import 'package:easy_invoice/data/api/apiService.dart';
import 'package:easy_invoice/data/responsemodel/AddSizeResponse.dart';
import 'package:easy_invoice/data/responsemodel/CountryPart/CountryResponse.dart';
import 'package:easy_invoice/data/responsemodel/EditProductResponse.dart';
import 'package:easy_invoice/data/responsemodel/GetAllProductResponse.dart';
import 'package:easy_invoice/data/responsemodel/GetAllSizeResponse.dart';
import 'package:easy_invoice/data/responsemodel/RegisterResponse.dart';
import 'package:easy_invoice/data/responsemodel/UserResponse.dart';
import 'package:easy_invoice/dataRequestModel/EditProductRequestModel.dart';
import 'package:easy_invoice/dataRequestModel/EditUserRoleRequestModel.dart';
import 'package:easy_invoice/dataRequestModel/UserRequestModel.dart';
import '../../dataRequestModel/AddCategoryRequestModel.dart';
import '../../dataRequestModel/AddProductRequestModel.dart';
import '../../dataRequestModel/AddSizeRequestModel.dart';
import '../../dataRequestModel/CityPart/AddCity.dart';
import '../../dataRequestModel/CityPart/EditCity.dart';
import '../../dataRequestModel/CountryPart/AddCountry.dart';
import '../../dataRequestModel/CountryPart/EditCountry.dart';
import '../../dataRequestModel/DeliveryPart/AddDeliveryCompanyNameRequestModel.dart';
import '../../dataRequestModel/EditCategoryModel.dart';
import '../../dataRequestModel/EditSizeModel.dart';
import '../../dataRequestModel/LoginRequestModel.dart';
import '../../dataRequestModel/RegisterRequestModel.dart';
import '../../dataRequestModel/ShopKeeperPart/ShopKeeperRequestModel.dart';
import '../../dataRequestModel/TownshipPart/AddTownship.dart';
import '../../dataRequestModel/TownshipPart/EditTownship.dart';
import '../responsemodel/AddCategoryResponseModel.dart';
import '../responsemodel/CategoryDeleteRespose.dart';
import '../responsemodel/CityPart/AddCityResponse.dart';
import '../responsemodel/CityPart/Cities.dart';
import '../responsemodel/CityPart/DeleteCityResponse.dart';
import '../responsemodel/CityPart/EditCityResponse.dart';
import '../responsemodel/CountryPart/DeleteCountryResponse.dart';
import '../responsemodel/CountryPart/EditCountryResponse.dart';
import '../responsemodel/CountryPart/RequestCountryResponse.dart';
import '../responsemodel/DeleteProductResponse.dart';
import '../responsemodel/DeleteUserRoleResponse.dart';
import '../responsemodel/DeliveryPart/AddDeliveryResponse.dart';
import '../responsemodel/DeliveryPart/FetchAllDeliveryName.dart';
import '../responsemodel/EditUserRoleResponse.dart';
import '../responsemodel/GetAllCategoryDetail.dart';
import '../responsemodel/LoginResponse.dart';
import '../responsemodel/ProductResponse.dart';
import '../responsemodel/ShopKeeperResponsePart/ShopKeeperResponse.dart';
import '../responsemodel/SizeDeleteResponse.dart';
import '../responsemodel/TownshipsPart/AddTownshipResponse.dart';
import '../responsemodel/TownshipsPart/AllTownshipResponse.dart';
import '../responsemodel/TownshipsPart/DeleteTownshipResponse.dart';
import '../responsemodel/TownshipsPart/EditTownshipResponse.dart';
import '../responsemodel/UpdateCateResponse.dart';
import '../responsemodel/UpdateSizeResponse.dart';
import '../responsemodel/UserRoleResponse.dart';

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

  //request for add  country
  Future<RequestCountryResponse> addCountry(AddCountry addCountry) async {
    try {
      final response = await _apiService.requestCountry(addCountry);
      return response;
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
  Future<List<CategoryItem>> getCategory() async {
    try {
      final response = await _apiService.getAllCategories();
      return response.data.data;
    } catch (error) {
      throw Exception('Failed to fetch category: $error');
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

  /*//fetch all delivery company name
  Future<List<AllDeliveryName>> fetchAllDeliveryCompanyName() async {
    try {
      final response = await _apiService.fetchAllDeliveryCompanyName();
      return response;
    } catch (error) {
      throw Exception('Failed to fetch delivery company name: $error');
    }
  }
*/

  //fetch all sizes
  Future<List<SizeItems>> getSizes() async {
    try {
      final response = await _apiService.getAllSizes();
      return response.data.data;
    } catch (error) {
      rethrow;
    }
  }

//to delete category by id

  Future<DeleteCategory> deleteCategory(int id) async {
    try {
      final response = await _apiService.deleteCategory(id);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //to delete country by id
  Future<DeleteCountryResponse> deleteCountry(int id) async {
    try {
      final response = await _apiService.deleteCountry(id);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //to delete city by id
  Future<DeleteCityResponse> deleteCity(int id) async {
    try {
      final response = await _apiService.deleteCity(id);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //to delete township by id
  Future<DeleteTownshipResponse> deleteTownship(int id) async {
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

/*  //to fetch all product item by category id
  Future<List<ProductItem>> fetchAllProductByCateId(int id) async {
    try {
      final response = await _apiService.fetchAllProductByCateId(id);
      return response;
    } catch (error) {
      rethrow;
    }
  }*/

  //to delete product item by id

  Future<DeleteProductResponse> deleteProductItem(int id) async {
    try {
      final response = await _apiService.deleteProductItem(id);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //to delete user role by id

  Future<DeleteUserRoleResponse> deleteUserRole(int id) async {
    try {
      final response = await _apiService.deleteUserRole(id);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //to delete size by id

  Future<SizeDeleteResponse> deleteSize(int id) async {
    try {
      final response = await _apiService.deleteSize(id);
      return response;
    } catch (error) {
      rethrow;
    }
  }

// update category by id

  Future<CategoryUpdateResponse> updateCategory(
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

  Future<SizeUpdateResponse> updateSize(EditSize editSize, int id) async {
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
