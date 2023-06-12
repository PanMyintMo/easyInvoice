import 'package:easy_invoice/data/api/apiService.dart';
import 'package:easy_invoice/data/responsemodel/RegisterResponse.dart';
import 'package:easy_invoice/dataModel/AddCategoryRequestModel.dart';
import 'package:easy_invoice/dataModel/EditCategoryModel.dart';
import 'package:easy_invoice/dataModel/LoginRequestModel.dart';
import 'package:easy_invoice/dataModel/RegisterRequestModel.dart';
import '../responsemodel/AddCategoryResponseModel.dart';
import '../responsemodel/CategoryDeleteRespose.dart';
import '../responsemodel/GetAllCategoryDetail.dart';
import '../responsemodel/LoginResponse.dart';
import '../responsemodel/UpdateCateResponse.dart';

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

//to get all category
  Future<List<CategoryData>> getCategory() async {
    try {
      final response = await _apiService.getAllCategories();
      return response;
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

// update category by id

Future<CategoryUpdateResponse> updateCategory(EditCategory editCategory,int id) async{
    try{
      final response = await _apiService.updateCategory(editCategory, id);
      return response;
    }
    catch(error){
      rethrow;
    }
}
}
