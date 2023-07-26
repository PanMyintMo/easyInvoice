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
import '../../dataRequestModel/CityPart/AddCity.dart';
import '../../dataRequestModel/CityPart/EditCity.dart';
import '../../dataRequestModel/CountryPart/AddCountry.dart';
import '../../dataRequestModel/CountryPart/EditCountry.dart';
import '../../dataRequestModel/DeliveryPart/AddDeliveryCompanyNameRequestModel.dart';
import '../../dataRequestModel/EditCategoryModel.dart';
import '../../dataRequestModel/EditSizeModel.dart';
import '../../dataRequestModel/EditUserRoleRequestModel.dart';
import '../../dataRequestModel/LoginRequestModel.dart';
import '../../dataRequestModel/RegisterRequestModel.dart';
import '../../dataRequestModel/ShopKeeperPart/ShopKeeperRequestModel.dart';
import '../responsemodel/AddCategoryResponseModel.dart';
import '../responsemodel/CategoryDeleteRespose.dart';
import '../responsemodel/CityPart/AddCityResponse.dart';
import '../responsemodel/CityPart/Cities.dart';
import '../responsemodel/CityPart/DeleteCityResponse.dart';
import '../responsemodel/CityPart/EditCityResponse.dart';
import '../responsemodel/CountryPart/CountryResponse.dart';
import '../responsemodel/CountryPart/DeleteCountryResponse.dart';
import '../responsemodel/CountryPart/EditCountryResponse.dart';
import '../responsemodel/CountryPart/RequestCountryResponse.dart';
import '../responsemodel/DeleteProductResponse.dart';
import '../responsemodel/DeleteUserRoleResponse.dart';
import '../responsemodel/DeliveryPart/AddDeliveryResponse.dart';
import '../responsemodel/EditUserRoleResponse.dart';
import '../responsemodel/LoginResponse.dart';
import '../responsemodel/ProductByCategoryIdResponse.dart';
import '../responsemodel/ProductResponse.dart';
import '../responsemodel/RegisterResponse.dart';
import '../responsemodel/ShopKeeperResponsePart/ShopKeeperResponse.dart';
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

// fetch request country response
  Future<RequestCountryResponse> requestCountry(AddCountry addCountry) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/add-country',
        data: addCountry.toJson(),
      );
      if (response.statusCode == 200) {
        final RequestCountryResponse data = RequestCountryResponse.fromJson(response.data);
        return data;
      } else {
        // print("My response status code is ${response.statusCode}");
        throw DioError(
          requestOptions: RequestOptions(path: '/api/add-country'),
          response: response,
        );
      }
    } catch (error) {
      throw DioError(
        requestOptions: RequestOptions(path: '/api/add-country'),
        error: error,
      );
    }
  }

  //edit country response
  Future<EditCountryResponse> editCountry(int id,EditCountry editCountry) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/edit-country/$id',
        data: editCountry.toJson(),
      );
      if (response.statusCode == 200) {
        final EditCountryResponse data = EditCountryResponse.fromJson(response.data);
        return data;
      } else {
        // print("My response status code is ${response.statusCode}");
        throw DioError(
          requestOptions: RequestOptions(path: '/api/eidt-country'),
          response: response,
        );
      }
    } catch (error) {
      throw DioError(
        requestOptions: RequestOptions(path: '/api/edit-country'),
        error: error,
      );
    }
  }

  //edit city response
  Future<EditCityResponse> editCity(int id,EditCity editCity) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/edit-city/$id',
        data: editCity.toJson(),
      );
      if (response.statusCode == 200) {
        final EditCityResponse data = EditCityResponse.fromJson(response.data);
        return data;
      } else {
        throw DioError(
          requestOptions: RequestOptions(path: '/api/edit-city'),
          response: response,
        );
      }
    } catch (error) {
      throw DioError(
        requestOptions: RequestOptions(path: '/api/edit-city'),
        error: error,
      );
    }
  }

// fetch request city response
  Future<AddCityResponse> requestCity(AddCity addCity) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/add-city',
        data: addCity.toJson(),
      );
      if (response.statusCode == 200) {
        final AddCityResponse data = AddCityResponse.fromJson(response.data);
        return data;
      } else {
        // print("My response status code is ${response.statusCode}");
        throw DioError(
          requestOptions: RequestOptions(path: '/api/add-city'),
          response: response,
        );
      }
    } catch (error) {
      throw DioError(
        requestOptions: RequestOptions(path: '/api/add-city'),
        error: error,
      );
    }
  }

// add delivery company name
  Future<AddDeliveryResponse> AddDelivery(AddDeliveryRequestModel addDeliveryRequestModel) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/add-delivery-companyname',
        data: addDeliveryRequestModel.toJson(),
      );
      if (response.statusCode == 200) {
        final AddDeliveryResponse data = AddDeliveryResponse.fromJson(response.data);
        return data;
      } else {
        // print("My response status code is ${response.statusCode}");
        throw DioError(
          requestOptions: RequestOptions(path: '/api/add-delivery-companyname'),
          response: response,
        );
      }
    } catch (error) {
      throw DioError(
        requestOptions: RequestOptions(path: '/api/add-delivery-companyname'),
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
      //    print("AddCategory data is ${response.data}");

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
      //      print("Add Product data is ${response.data}");

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

  //Add request product shopkeeper

  Future<AddShopKeeperResponse> addShopKeeperRequestProduct(
      ShopKeeperRequestModel shopKeeperRequestModel) async {
    try {
      final Response response = await _dio.post(
          'https://mmeasyinvoice.com/api/add-shopkeeper',
          data: shopKeeperRequestModel.toJson());
      print("Add shopkeeper request data is ${response.data}");

      if (response.statusCode == 200) {
        final AddShopKeeperResponse addShopKeeperResponse =
            AddShopKeeperResponse.fromJson(response.data);
        return addShopKeeperResponse;
      } else {
        throw DioError(
          requestOptions: RequestOptions(path: '/api/add-shopkeeper'),
          response: response,
        );
      }
    } catch (error) {
      throw DioError(
        requestOptions: RequestOptions(path: '/api/add-shopkeeper'),
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
        final response = await _dio
            .get('https://mmeasyinvoice.com/api/categories?page=$currentPage');
        //    print('Category Response is ${response.data}');

        if (response.statusCode == 200) {
          final dynamic responseData = response.data;

          final categoryDataResponse =
              CategoryDataResponse.fromJson(responseData);
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
          last_page_url:
              'https://mmeasyinvoice.com/api/categories?page=$currentPage',
          links: [],
          next_page_url: (currentPage < categoryData.last_page)
              ? 'https://mmeasyinvoice.com/api/categories?page=${currentPage + 1}'
              : '',
          path: 'https://mmeasyinvoice.com/api/categories',
          per_page: allCategories.length,
          prev_page_url: (currentPage > 1)
              ? 'https://mmeasyinvoice.com/api/categories?page=${currentPage - 1}'
              : null,
          to: allCategories.length,
          total: 0,
        ),
      );
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  //fetch all city from db
  Future<CityResponse> cities() async {
    try {
      int currentPage = 1;
      CityData? cityData; // Change to nullable type
      List<City> cityItems = [];

      while (true) {
        final response = await _dio.get('https://mmeasyinvoice.com/api/cities?page=$currentPage');
        print('Cities Response is ${response.data}');

        if (response.statusCode == 200) {
          final dynamic responseData = response.data;
          final cities = CityResponse.fromJson(responseData);
          cityData = cities.data; // Update the cityData variable

          final List<City> cityItem = cityData.cities;
          cityItems.addAll(cityItem);

          if (currentPage == cityData.lastPage) {
            break;
          } else {
            currentPage++;
          }
        } else {
          throw Exception('Failed to fetch city');
        }
      }

      if (cityData == null) {
        throw Exception('No city data found');
      }

      return CityResponse(
        data: CityData(
          currentPage: cityData.currentPage,
          cities: cityItems,
          firstPageUrl: 'https://mmeasyinvoice.com/api/cities?page=1',
          lastPage: cityData.lastPage,
          lastPageUrl: 'https://mmeasyinvoice.com/api/cities?page=${cityData.lastPage}',
          links: cityData.links,
          nextPageUrl: (currentPage < cityData.lastPage)
              ? 'https://mmeasyinvoice.com/api/cities?page=${currentPage + 1}'
              : null,
        ),
      );
    } catch (e) {
      throw Exception('Failed to fetch cities: $e');
    }
  }
  //fetch all country from db
  Future<CountryResponse> country() async {
    try {
      int currentPage = 1;
      CountryData? countryData; // Change to nullable type
      List<Country> countryItems = [];

      while (true) {
        final response = await _dio.get('https://mmeasyinvoice.com/api/countries?page=$currentPage');
        print('Country Response is ${response.data}');

        if (response.statusCode == 200) {
          final dynamic responseData = response.data;
          final countries = CountryResponse.fromJson(responseData);
          countryData = countries.data; // Update the cityData variable

          final List<Country> countryItem = countryData.data;
          countryItems.addAll(countryItem);

          if (currentPage == countryData.lastPage) {
            break;
          } else {
            currentPage++;
          }
        } else {
          throw Exception('Failed to fetch country');
        }
      }

      if (countryData == null) {
        throw Exception('No country data found');
      }

      return CountryResponse(
        data: CountryData(
          currentPage: countryData.currentPage,
          data: countryItems,
          firstPageUrl: 'https://mmeasyinvoice.com/api/countries?page=1',
          lastPage: countryData.lastPage,
          lastPageUrl: 'https://mmeasyinvoice.com/api/countries?page=${countryData.lastPage}',
          links: countryData.links,
          nextPageUrl: (currentPage < countryData.lastPage)
              ? 'https://mmeasyinvoice.com/api/countries?page=${currentPage + 1}'
              : null, from: 1, path: '',
          perPage: countryItems.length, prevPageUrl: '',
          to: countryItems.length, total: 0,
        ), status: 200, message: 'Success',
      );
    } catch (e) {
      throw Exception('Failed to fetch countries: $e');
    }
  }


//fetch all product by category Id from db

  Future<List<ProductItem>> fetchAllProductByCateId(int id) async {
    try {
      final response = await _dio.get(
          'https://mmeasyinvoice.com/api/productByCategoryId/$id');
      print('All Product by category id Response: ${response.data}');

      if (response.statusCode == 200) {
        final responseData = response.data;
        print('Response data for cateid of product $responseData');
        final productByCategoryIdResponse= ProductByCategoryIdResponse.fromJson(responseData);

        return productByCategoryIdResponse.data;
      } else {
        throw Exception('Invalid data format for category by id field');
      }
    } catch (e) {
      throw Exception('Failed to fetch product role: $e');
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
        final response = await _dio
            .get('https://mmeasyinvoice.com/api/products?page=$currentPage');
        //  print('Product Response is ${response.data}');
        if (response.statusCode == 200) {
          final dynamic responseData = response.data;

          final productDataResponse =
              GetAllProductResponse.fromJson(responseData);
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
          lastPageUrl:
              'https://mmeasyinvoice.com/api/products?page=$currentPage',
          links: [],
          nextPageUrl: (currentPage < productData!.lastPage)
              ? 'https://mmeasyinvoice.com/api/products?page=${currentPage + 1}'
              : '',
          path: 'https://mmeasyinvoice.com/api/products',
          perPage: allProduct.length,
          prevPageUrl: (currentPage > 1)
              ? 'https://mmeasyinvoice.com/api/products?page=${currentPage - 1}'
              : null,
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
        final response = await _dio
            .get('https://mmeasyinvoice.com/api/sizes?page=$currentPage');
        //   print('Size Response is ${response.data}');

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
          last_page_url:
              'https://mmeasyinvoice.com/api/sizes?page=$currentPage',
          links: [],
          next_page_url: (currentPage < sizeData.last_page)
              ? 'https://mmeasyinvoice.com/api/sizes?page=${currentPage + 1}'
              : '',
          path: 'https://mmeasyinvoice.com/api/sizes',
          per_page: allSizes.length,
          prev_page_url: (currentPage > 1)
              ? 'https://mmeasyinvoice.com/api/sizes?page=${currentPage - 1}'
              : null,
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
      int currentPage = 1;
      List<UserData> allUser = [];
      UserRoleResponse userRoleResponse;
      while (true) {
        final response =
        await _dio.get('https://mmeasyinvoice.com/api/users?page=$currentPage');
        print('All User Response is ${response.data}');

        if (response.statusCode == 200) {
          final dynamic responseData = response.data;
          userRoleResponse = UserRoleResponse.fromJson(responseData);
          allUser.addAll(userRoleResponse.data);

          if (currentPage == userRoleResponse.lastPage) {
            break;
          } else {
            currentPage++;
          }
        } else {
          throw Exception('Failed to fetch all users');
        }
      }

      return UserRoleResponse(
        currentPage: currentPage,
        data: allUser,
        firstPageUrl: 'https://mmeasyinvoice.com/api/users?page=1',
        from: 1,
        lastPage: currentPage,
        lastPageUrl: 'https://mmeasyinvoice.com/api/users?page=$currentPage',
        links: [],
        nextPageUrl: (currentPage < userRoleResponse.lastPage)
            ? 'https://mmeasyinvoice.com/api/users?page=${currentPage + 1}'
            : '',
        path: 'https://mmeasyinvoice.com/api/users',
        perPage: allUser.length,
        prevPageUrl: (currentPage > 1)
            ? 'https://mmeasyinvoice.com/api/users?page=${currentPage - 1}'
            : null,
        to: allUser.length,
        total: 0, // You can set the correct value for the total number of users
        status: 200, // Set the appropriate status code
        message: 'Success', // Set the appropriate message
      );
    } catch (e) {
      throw Exception('Failed to fetch user roles: $e');
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


  //Delete country by id

  Future<DeleteCountryResponse> deleteCountry(int id) async {
    try {
      final response =
      await _dio.post('https://mmeasyinvoice.com/api/delete-country/$id');
     //  print("Delete Country status response is ${response.statusCode}");
      if (response.statusCode == 200) {
        DeleteCountryResponse deleteCountry = DeleteCountryResponse.fromJson(response.data);
        return deleteCountry;
      } else {
        throw Exception('Something wrong!');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  //Delete city by id

  Future<DeleteCityResponse> deleteCity(int id) async {
    try {
      final response =
      await _dio.post('https://mmeasyinvoice.com/api/delete-city/$id');
      print("Delete City status response is ${response.statusCode}");
      if (response.statusCode == 200) {
        DeleteCityResponse deleteCity = DeleteCityResponse.fromJson(response.data);
        return deleteCity;
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
        DeleteProductResponse deleteProductResponse =
            DeleteProductResponse.fromJson(response.data);
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
  Future<CategoryUpdateResponse> updateCategory(
      EditCategory editCategory, int id) async {
    try {
      final response = await _dio.post(
          'https://mmeasyinvoice.com/api/edit-category/$id',
          data: editCategory.toJson());
      //   print('Update response is ${response.data}');
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
  Future<EditProductResponse> updateProductItem(
      EditProductRequestModel editProductItem, int id) async {
    try {
      final response = await _dio.post(
          'https://mmeasyinvoice.com/api/edit-product/$id',
          data: editProductItem.toJson());
      print('Update Product Item response is ${response.data}');
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

  Future<AddSizeResponse> addSize(
      AddSizeRequestModel addSizeRequestModel) async {
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

// for user role

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
