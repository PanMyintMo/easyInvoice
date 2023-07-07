

import 'package:dio/dio.dart';
import 'package:easy_invoice/data/responsemodel/AddSizeResponse.dart';
import 'package:easy_invoice/data/responsemodel/EditProductResponse.dart';
import 'package:easy_invoice/data/responsemodel/GetAllCategoryDetail.dart';
import 'package:easy_invoice/data/responsemodel/GetAllProductResponse.dart';
import 'package:easy_invoice/data/responsemodel/GetAllSizeResponse.dart';
import 'package:easy_invoice/data/responsemodel/UpdateCateResponse.dart';
import 'package:easy_invoice/data/responsemodel/UserResponse.dart';
import 'package:easy_invoice/dataRequestModel/EditProductRequestModel.dart';
import 'package:easy_invoice/dataRequestModel/UserRequestModel.dart';
import 'package:easy_invoice/network/interceptor.dart';
import '../../dataRequestModel/AddCategoryRequestModel.dart';
import '../../dataRequestModel/AddProductRequestModel.dart';
import '../../dataRequestModel/AddSizeRequestModel.dart';
import '../../dataRequestModel/EditCategoryModel.dart';
import '../../dataRequestModel/EditSizeModel.dart';
import '../../dataRequestModel/EditUserRoleRequestModel.dart';
import '../../dataRequestModel/LoginRequestModel.dart';
import '../../dataRequestModel/RegisterRequestModel.dart';
import '../responsemodel/AddCategoryResponseModel.dart';
import '../responsemodel/CategoryDeleteRespose.dart';
import '../responsemodel/DeleteProductResponse.dart';
import '../responsemodel/DeleteUserRoleResponse.dart';
import '../responsemodel/EditUserRoleResponse.dart';
import '../responsemodel/LoginResponse.dart';
import '../responsemodel/ProductResponse.dart';
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

  //Add product

  Future<ProductResponse> addProduct(
      AddProductRequestModel addProductRequestModel) async {
    try {
      final Response response = await _dio.post(
          'https://mmeasyinvoice.com/api/add-product',
          data: addProductRequestModel.toJson());
      print("Add Product data is ${response.data}");

      if (response.statusCode == 200) {
        final ProductResponse addProductResponseData =
        ProductResponse.fromJson(response.data);
        return addProductResponseData;
      } else {
        throw DioError(
          requestOptions: RequestOptions(path: '/api/add-product'),
          response: response,
        );
      }
    } catch (error) {
      throw DioError(
        requestOptions: RequestOptions(path: '/api/add-product'),
        error: error,
      );
    }
  }
  //fetch all category from db

  Future<CategoryDataResponse> getAllCategories() async {
    try {
      int currentPage = 1;
      CategoryData categoryData;
      List<CategoryItem> allCategories = [];

      while (true) {
        final response = await _dio.get('https://mmeasyinvoice.com/api/categories?page=$currentPage');
        print('Category Response is ${response.data}');

        if (response.statusCode == 200) {
          final dynamic responseData = response.data;

          final categoryDataResponse = CategoryDataResponse.fromJson(responseData);
            categoryData = categoryDataResponse.data;
          final List<CategoryItem> categories = categoryData.data;
          allCategories.addAll(categories);

          if (currentPage == categoryData.last_page) {
            break;
          } else {
            currentPage++;
          }
        } else {
          throw Exception('Failed to fetch categories');
        }
      }

      return CategoryDataResponse(
        data: CategoryData(
          current_page: currentPage,
          data: allCategories,
          first_page_url: 'https://mmeasyinvoice.com/api/categories?page=1',
          from: 1,
          last_page: currentPage,
          last_page_url: 'https://mmeasyinvoice.com/api/categories?page=$currentPage',
          links: [],
          next_page_url: (currentPage < categoryData.last_page) ? 'https://mmeasyinvoice.com/api/categories?page=${currentPage + 1}' : '',
          path: 'https://mmeasyinvoice.com/api/categories',
          per_page: allCategories.length,
          prev_page_url: (currentPage > 1) ? 'https://mmeasyinvoice.com/api/categories?page=${currentPage - 1}' : null,
          to: allCategories.length,
          total: 0,
        ),
      );
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  //fetch all product from db
  Future<GetAllProductResponse> fetchAllProducts() async {
    try {
      int currentPage = 1;
      ProductData? productData; // Make the productData variable nullable
      List<ProductListItem> allProduct = [];
      bool isLastPage = false;

      while (!isLastPage) {
        final response = await _dio.get('https://mmeasyinvoice.com/api/products?page=$currentPage');
      //  print('Product Response is ${response.data}');
        if (response.statusCode == 200) {
          final dynamic responseData = response.data;

          final productDataResponse = GetAllProductResponse.fromJson(responseData);
          productData = productDataResponse.data;
          final List<ProductListItem> products = productData.data;
          allProduct.addAll(products);

          if (currentPage == productData.lastPage) {
            isLastPage = true;
          } else {
            currentPage++;
          }
        }
      }

      return GetAllProductResponse(
          data: ProductData(
            currentPage: currentPage,
            data: allProduct,
            firstPageUrl: 'https://mmeasyinvoice.com/api/products?page=1',
            from: 1,
            lastPage: currentPage,
            lastPageUrl: 'https://mmeasyinvoice.com/api/products?page=$currentPage',
            links: [],
            nextPageUrl: (currentPage < productData!.lastPage) ? 'https://mmeasyinvoice.com/api/products?page=${currentPage + 1}' : '',
            path: 'https://mmeasyinvoice.com/api/products',
            perPage: allProduct.length,
            prevPageUrl: (currentPage > 1) ? 'https://mmeasyinvoice.com/api/products?page=${currentPage - 1}' : null,
            to: allProduct.length,
            total: 0,
          ),
        );

    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  //fetch all sizes from db
  Future<GetAllSizeResponse> getAllSizes() async {
    try {
      int currentPage = 1;
      SizeData sizeData;
      List<SizeItems> allSizes = [];

      while (true) {
        final response = await _dio.get('https://mmeasyinvoice.com/api/sizes?page=$currentPage');
        print('Size Response is ${response.data}');

        if (response.statusCode == 200) {
          final dynamic responseData = response.data;

          final sizeDataResponse = GetAllSizeResponse.fromJson(responseData);

          sizeData = sizeDataResponse.data;
          final List<SizeItems> sizes = sizeData.data;
          allSizes.addAll(sizes);

          if (currentPage == sizeData.last_page) {
            break;
          } else {
            currentPage++;
          }
        } else {
          throw Exception('Failed to fetch all sizes');
        }
      }

      return GetAllSizeResponse(
        data: SizeData(
          current_page: currentPage,
          data: allSizes,
          first_page_url: 'https://mmeasyinvoice.com/api/sizes?page=1',
          from: 1,
          last_page: currentPage,
          last_page_url: 'https://mmeasyinvoice.com/api/sizes?page=$currentPage',
          links: [],
          next_page_url: (currentPage < sizeData.last_page) ? 'https://mmeasyinvoice.com/api/sizes?page=${currentPage + 1}' : '',
          path: 'https://mmeasyinvoice.com/api/sizes',
          per_page: allSizes.length,
          prev_page_url: (currentPage > 1) ? 'https://mmeasyinvoice.com/api/sizes?page=${currentPage - 1}' : null,
          to: allSizes.length,
          total: 0,
        ),
      );
    } catch (e) {
      throw Exception('Failed to fetch sizes: $e');
    }
  }

//fetch all user role from db
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

//Delete product by id

  Future<DeleteProductResponse> deleteProductItem(int id) async {
    try {
      final response =
      await _dio.post('https://mmeasyinvoice.com/api/delete-product/$id');
     //  print("Delete Product status response is ${response.statusCode}");
      if (response.statusCode == 200) {
        DeleteProductResponse deleteProductResponse = DeleteProductResponse.fromJson(response.data);
        return deleteProductResponse;
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
   // print("Delete Size status response is ${response.statusCode}");
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
Future<CategoryUpdateResponse> updateCategory(EditCategory editCategory,
    int id) async {
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



//to update product item by id
  Future<EditProductResponse> updateProductItem(EditProductRequestModel editProductItem, int id) async {
    try {
      final response = await _dio.post(
          'https://mmeasyinvoice.com/api/edit-product/$id',
          data: editProductItem.toJson());
      print('Update response is ${response.data}');
      if (response.statusCode == 200) {
        EditProductResponse updateProductItem =
        EditProductResponse.fromJson(response.data);
        return updateProductItem;
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
    //print('Update response is ${response.data}');
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

Future<AddSizeResponse> addSize(AddSizeRequestModel addSizeRequestModel) async {
  try {
    final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/add-size',
        data: addSizeRequestModel.toJson());
   // print("Add Size Response data is ${response.data}");

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
  //  print("Delete User role status response is ${response.statusCode}");
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
