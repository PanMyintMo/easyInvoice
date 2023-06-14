import 'package:easy_invoice/data/api/apiService.dart';
import 'package:easy_invoice/data/responsemodel/AddSizeResponse.dart';
import 'package:easy_invoice/data/responsemodel/GetAllSizeResponse.dart';
import 'package:easy_invoice/data/responsemodel/RegisterResponse.dart';
import 'package:easy_invoice/dataModel/AddCategoryRequestModel.dart';
import 'package:easy_invoice/dataModel/AddSizeRequestModel.dart';
import 'package:easy_invoice/dataModel/EditCategoryModel.dart';
import 'package:easy_invoice/dataModel/LoginRequestModel.dart';
import 'package:easy_invoice/dataModel/RegisterRequestModel.dart';
import '../../dataModel/EditSizeModel.dart';
import '../responsemodel/AddCategoryResponseModel.dart';
import '../responsemodel/CategoryDeleteRespose.dart';
import '../responsemodel/GetAllCategoryDetail.dart';
import '../responsemodel/LoginResponse.dart';
import '../responsemodel/SizeDeleteResponse.dart';
import '../responsemodel/UpdateCateResponse.dart';
import '../responsemodel/UpdateSizeResponse.dart';

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



//to get all category
  Future<List<CategoryData>> getCategory() async {
    try {
      final response = await _apiService.getAllCategories();
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //get all sizes
  Future<List<GetAllSizeResponse>> getSizes() async {
    try {
      final response = await _apiService.getAllSize();
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

Future<CategoryUpdateResponse> updateCategory(EditCategory editCategory,int id) async{
    try{
      final response = await _apiService.updateCategory(editCategory, id);
      return response;
    }
    catch(error){
      rethrow;
    }
}

// update size by id

  Future<SizeUpdateResponse> updateSize(EditSize editSize,int id) async{
    try{
      final response = await _apiService.updateSize(editSize, id);
      return response;
    }
    catch(error){
      rethrow;
    }
  }
}
