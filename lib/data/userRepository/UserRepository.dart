import 'package:easy_invoice/data/api/apiService.dart';
import 'package:easy_invoice/data/responsemodel/AddSizeResponse.dart';
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
import '../../dataRequestModel/DeliveryPart/AddDeliveryCompanyNameRequestModel.dart';
import '../../dataRequestModel/EditCategoryModel.dart';
import '../../dataRequestModel/EditSizeModel.dart';
import '../../dataRequestModel/LoginRequestModel.dart';
import '../../dataRequestModel/RegisterRequestModel.dart';
import '../../dataRequestModel/ShopKeeperPart/ShopKeeperRequestModel.dart';
import '../responsemodel/AddCategoryResponseModel.dart';
import '../responsemodel/CategoryDeleteRespose.dart';
import '../responsemodel/CityPart/Cities.dart';
import '../responsemodel/DeleteProductResponse.dart';
import '../responsemodel/DeleteUserRoleResponse.dart';
import '../responsemodel/DeliveryPart/AddDeliveryResponse.dart';
import '../responsemodel/EditUserRoleResponse.dart';
import '../responsemodel/GetAllCategoryDetail.dart';
import '../responsemodel/LoginResponse.dart';
import '../responsemodel/ProductResponse.dart';
import '../responsemodel/ShopKeeperResponsePart/ShopKeeperResponse.dart';
import '../responsemodel/SizeDeleteResponse.dart';
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
      final response = await _apiService.addShopKeeperRequestProduct(shopKeeperRequestModel);
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
      throw Exception('Failed to get city: $error');
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

  //to add delivery company

  Future<AddDeliveryResponse> addDelivery(AddDeliveryRequestModel addDeliveryRequestModel) async{
    try{
      final response= await _apiService.AddDelivery(addDeliveryRequestModel);
      return response;
    }
    catch(e){
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

  // update product by id

  Future<EditProductResponse> updateProductItem(
      EditProductRequestModel editProductRequestModel, int id) async {
    try {
      final response = await _apiService.updateProductItem(editProductRequestModel, id);
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
