import 'package:dio/dio.dart';
import 'package:easy_invoice/data/responsemodel/GetAllCategoryDetail.dart';
import 'package:easy_invoice/dataModel/AddCategoryRequestModel.dart';
import 'package:easy_invoice/dataModel/LoginRequestModel.dart';
import 'package:easy_invoice/network/interceptor.dart';
import '../../dataModel/RegisterRequestModel.dart';
import '../responsemodel/AddCategoryResponseModel.dart';
import '../responsemodel/CategoryDeleteRespose.dart';
import '../responsemodel/LoginResponse.dart';
import '../responsemodel/RegisterResponse.dart';

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
      print('Categories are ${response.data}.');

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

//Delete category by id

  Future<DeleteCategory> deleteCategory(int id) async {
    try {
      final response =
          await _dio.post('https://mmeasyinvoice.com/api/delete-category/$id');

      print("Delete category status response is ${response.statusCode}");
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
}
