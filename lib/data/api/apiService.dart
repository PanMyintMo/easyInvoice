import 'package:dio/dio.dart';
import 'package:easy_invoice/data/responsemodel/AddSizeResponse.dart';
import 'package:easy_invoice/data/responsemodel/GetAllCategoryDetail.dart';
import 'package:easy_invoice/data/responsemodel/GetAllSizeResponse.dart';
import 'package:easy_invoice/data/responsemodel/UpdateCateResponse.dart';
import 'package:easy_invoice/data/responsemodel/UserResponse.dart';
import 'package:easy_invoice/dataRequestModel/UserRequestModel.dart';
import 'package:easy_invoice/network/interceptor.dart';
import '../../dataRequestModel/AddCategoryRequestModel.dart';
import '../../dataRequestModel/AddSizeRequestModel.dart';
import '../../dataRequestModel/EditCategoryModel.dart';
import '../../dataRequestModel/EditSizeModel.dart';
import '../../dataRequestModel/EditUserRoleRequestModel.dart';
import '../../dataRequestModel/LoginRequestModel.dart';
import '../../dataRequestModel/RegisterRequestModel.dart';
import '../responsemodel/AddCategoryResponseModel.dart';
import '../responsemodel/CategoryDeleteRespose.dart';
import '../responsemodel/DeleteUserRoleResponse.dart';
import '../responsemodel/EditUserRoleResponse.dart';
import '../responsemodel/LoginResponse.dart';
import '../responsemodel/RegisterResponse.dart';
import '../responsemodel/SizeDeleteResponse.dart';
import '../responsemodel/UpdateSizeResponse.dart';
import '../responsemodel/UserRoleResponse.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';
    _dio.interceptors.add(MyRequestInterceptor('tokenKey'));
  }

  Future<RegisterResponse> signUp(
      RegisterRequestModel registerRequestModel) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/register',
        data: registerRequestModel.toJson(),
      );
      //  print('Response Status Code: ${response.statusCode}');
      //  print('Response Data: ${response.data}');
      if (response.statusCode == 200) {
        final RegisterResponse data = RegisterResponse.fromJson(response.data);
        return data;
      } else {
        //   print("My response status code is ${response.statusCode}");
        throw DioError(
            requestOptions: RequestOptions(path: '/api/register'),
            response: response);
      }
    } catch (error) {
      throw DioError(
          requestOptions: RequestOptions(path: '/api/register'), error: error);
    }
  }

  Future<LoginResponse> signIn(LoginRequestModel loginRequestModel) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/login',
        data: loginRequestModel.toJson(),
      );
      if (response.statusCode == 200) {
        final LoginResponse data = LoginResponse.fromJson(response.data);
        return data;
      } else {
        // print("My response status code is ${response.statusCode}");
        throw DioError(
          requestOptions: RequestOptions(path: '/api/login'),
          response: response,
        );
      }
    } catch (error) {
      throw DioError(
        requestOptions: RequestOptions(path: '/api/login'),
        error: error,
      );
    }
  }

  //Add category

  Future<AddCategoryResponse> addCategory(
      AddCategoryRequestModel addCategoryRequestModel) async {
    try {
      final Response response = await _dio.post(
          'https://mmeasyinvoice.com/api/add-category',
          data: addCategoryRequestModel.toJson());
      print("AddCategory data is ${response.data}");

      if (response.statusCode == 200) {
        final AddCategoryResponse addCategoryResponseData =
            AddCategoryResponse.fromJson(response.data);
        return addCategoryResponseData;
      } else {
        throw DioError(
          requestOptions: RequestOptions(path: '/api/add-category'),
          response: response,
        );
      }
    } catch (error) {
      throw DioError(
        requestOptions: RequestOptions(path: '/api/add-category'),
        error: error,
      );
    }
  }

  //get all category from db
  Future<List<CategoryData>> getAllCategories() async {
    try {
      final response =
          await _dio.get('https://mmeasyinvoice.com/api/categories');

      if (response.statusCode == 200) {
        final dynamic responseData = response.data;

        if (responseData['data'] is List) {
          final List<CategoryData> categories = List<CategoryData>.from(
            responseData['data']
                .map((categoryJson) => CategoryData.fromJson(categoryJson)),
          );
          return categories;
        } else if (responseData['data'] is Map<String, dynamic>) {
          final CategoryData categoryDetail =
              CategoryData.fromJson(responseData['data']);
          return [categoryDetail];
        } else {
          throw Exception('Invalid data format for "data" field');
        }
      } else {
        throw Exception('Failed to fetch categories');
      }
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  //get all user role from db
  Future<UserRoleResponse> getAllUserRole() async {
    try {
      final response = await _dio.get('https://mmeasyinvoice.com/api/users');
      print('User Role Response are ${response.data}');
      if (response.statusCode == 200) {
        final responseData = response.data;
        return UserRoleResponse.fromJson(responseData);
      } else {
        throw Exception('Invalid data format for "data" field');
      }
    } catch (e) {
      throw Exception('Failed to fetch users role: $e');
    }
  }

//Delete category by id

  Future<DeleteCategory> deleteCategory(int id) async {
    try {
      final response =
          await _dio.post('https://mmeasyinvoice.com/api/delete-category/$id');
      // print("Delete category status response is ${response.statusCode}");
      if (response.statusCode == 200) {
        DeleteCategory deleteCategory = DeleteCategory.fromJson(response.data);
        return deleteCategory;
      } else {
        throw Exception('Something wrong!');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

//to delete size
  Future<SizeDeleteResponse> deleteSize(int id) async {
    try {
      final response =
          await _dio.post('https://mmeasyinvoice.com/api/delete-size/$id');
      print("Delete Size status response is ${response.statusCode}");
      if (response.statusCode == 200) {
        SizeDeleteResponse deleteSize =
            SizeDeleteResponse.fromJson(response.data);
        return deleteSize;
      } else {
        throw Exception('Something wrong!');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  //to update category by id
  Future<CategoryUpdateResponse> updateCategory(
      EditCategory editCategory, int id) async {
    try {
      final response = await _dio.post(
          'https://mmeasyinvoice.com/api/edit-category/$id',
          data: editCategory.toJson());
      print('Update response is ${response.data}');
      if (response.statusCode == 200) {
        CategoryUpdateResponse categoryUpdateResponse =
            CategoryUpdateResponse.fromJson(response.data);

        return categoryUpdateResponse;
      } else {
        throw Exception('Something wrong!');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  //to update size by id
  Future<SizeUpdateResponse> updateSize(EditSize editSize, int id) async {
    try {
      final response = await _dio.post(
          'https://mmeasyinvoice.com/api/edit-size/$id',
          data: editSize.toJson());
      print('Update response is ${response.data}');
      if (response.statusCode == 200) {
        SizeUpdateResponse sizeUpdateResponse =
            SizeUpdateResponse.fromJson(response.data);

        return sizeUpdateResponse;
      } else {
        throw Exception('Something wrong!');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  //Add Size to db

  Future<AddSizeResponse> addSize(
      AddSizeRequestModel addSizeRequestModel) async {
    try {
      final Response response = await _dio.post(
          'https://mmeasyinvoice.com/api/add-size',
          data: addSizeRequestModel.toJson());
      print("Add Size Response data is ${response.data}");

      if (response.statusCode == 200) {
        final AddSizeResponse addSizeResponse =
            AddSizeResponse.fromJson(response.data);
        return addSizeResponse;
      } else {
        throw DioError(
          requestOptions: RequestOptions(path: '/api/add-size'),
          response: response,
        );
      }
    } catch (error) {
      throw DioError(
        requestOptions: RequestOptions(path: '/api/add-size'),
        error: error,
      );
    }
  }

  //get all sizes from db
  Future<List<GetAllSizeResponse>> getAllSize() async {
    try {
      final response = await _dio.get('https://mmeasyinvoice.com/api/sizes');

      if (response.statusCode == 200) {
        final dynamic responseData = response.data;

        if (responseData['data'] is List) {
          final List<GetAllSizeResponse> size = List<GetAllSizeResponse>.from(
            responseData['data'].map(
                (categoryJson) => GetAllSizeResponse.fromJson(categoryJson)),
          );
          return size;
        } else if (responseData['data'] is Map<String, dynamic>) {
          final GetAllSizeResponse sizes =
              GetAllSizeResponse.fromJson(responseData['data']);
          return [sizes];
        } else {
          throw Exception('Invalid data format for "data" field');
        }
      } else {
        throw Exception('Failed to fetch sizes');
      }
    } catch (e) {
      throw Exception('Failed to fetch sizes: $e');
    }
  }

  //divide for user

  Future<UserResponse> user(UserRequestModel userRequestModel) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/add-user',
        data: userRequestModel.toJson(),
      );
      //print('User response are $response');
      // print('Response Status Code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final UserResponse data = UserResponse.fromJson(response.data);
        return data;
      } else {
        // print("My response status code is ${response.statusCode}");
        throw DioError(
          requestOptions: RequestOptions(path: '/api/add-user'),
          response: response,
        );
      }
    } catch (error) {
      throw DioError(
        requestOptions: RequestOptions(path: '/api/add-user'),
        error: error,
      );
    }
  }

  // Edit User Role
  Future<EditUserRoleResponse> editUserRole(
      EditUserRoleRequestModel editUserRoleRequestModel, int id) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/edit-user/$id',
        data: editUserRoleRequestModel.toJson(),
      );
      if (response.statusCode == 200) {
        final EditUserRoleResponse data =
            EditUserRoleResponse.fromJson(response.data);
        return data;
      } else {
        // print("My response status code is ${response.statusCode}");
        throw DioError(
          requestOptions: RequestOptions(path: '/api/edit-user'),
          response: response,
        );
      }
    } catch (error) {
      throw DioError(
        requestOptions: RequestOptions(path: '/api/edit-user'),
        error: error,
      );
    }
  }

  //to delete user role
  Future<DeleteUserRoleResponse> deleteUserRole(int id) async {
    try {
      final response =
      await _dio.post('https://mmeasyinvoice.com/api/delete-user/$id');
      print("Delete User role status response is ${response.statusCode}");
      if (response.statusCode == 200) {
        DeleteUserRoleResponse deleteUserRoleResponse =
        DeleteUserRoleResponse.fromJson(response.data);
        return deleteUserRoleResponse;
      } else {
        throw Exception('Something wrong!');
      }
    } catch (error) {
      throw Exception(error);
    }
  }


}
