import 'package:dio/dio.dart';
import 'package:easy_invoice/data/responsemodel/AddSizeResponse.dart';
import 'package:easy_invoice/data/responsemodel/EditProductResponse.dart';
import 'package:easy_invoice/data/responsemodel/GetAllPagnitaionDataResponse.dart';
import 'package:easy_invoice/data/responsemodel/GetAllProductResponse.dart';
import 'package:easy_invoice/data/responsemodel/common/UpdateResponse.dart';
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
import '../../dataRequestModel/DeliveryPart/AddOrderRequestModel.dart';
import '../../dataRequestModel/DeliveryPart/ChangeOrderProductQty.dart';
import '../../dataRequestModel/DeliveryPart/ChooseProductForOrderRequestModel.dart';
import '../../dataRequestModel/DeliveryPart/ProductInvoiceRequest.dart';
import '../../dataRequestModel/DeliveryPart/UpdateQuantityInBarcodeRequest.dart';
import '../../dataRequestModel/EditCategoryModel.dart';
import '../../dataRequestModel/EditSizeModel.dart';
import '../../dataRequestModel/EditUserRoleRequestModel.dart';
import '../../dataRequestModel/FaultyItemPart/AddFaultyItemRequest.dart';
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
import '../responsemodel/ShopKeeperResponsePart/DeliveredWarehouseRequest.dart';
import '../responsemodel/common/DeleteResponse.dart';
import '../responsemodel/CityPart/EditCityResponse.dart';
import '../responsemodel/CityPart/FetchCityByCountryId.dart';
import '../responsemodel/CountryPart/CountryResponse.dart';
import '../responsemodel/CountryPart/EditCountryResponse.dart';
import '../responsemodel/CountryPart/RequestCountryResponse.dart';
import '../responsemodel/DeliveryPart/AddDeliveryResponse.dart';
import '../responsemodel/DeliveryPart/AddOrderResponse.dart';
import '../responsemodel/DeliveryPart/ChangeOrderQtyResponse.dart';
import '../responsemodel/DeliveryPart/ChooseProductOrderResponse.dart';
import '../responsemodel/DeliveryPart/DeliCompanyNameByTownshipId.dart';
import '../responsemodel/DeliveryPart/DeliveryManResponse.dart';
import '../responsemodel/DeliveryPart/FetchAllDeliveryName.dart';
import '../responsemodel/DeliveryPart/ProductInvoiceResponse.dart';
import '../responsemodel/DeliveryPart/UpdateQuantityBarcodeResponse.dart';
import '../responsemodel/EditUserRoleResponse.dart';
import '../responsemodel/FaultyItemPart/AddFaultyItemResponse.dart';
import '../responsemodel/FaultyItemPart/AllFaultyItems.dart';
import '../responsemodel/Login&RegisterResponse/EditCompanyProfileResponse.dart';
import '../responsemodel/Login&RegisterResponse/LoginResponse.dart';
import '../responsemodel/Login&RegisterResponse/CompanyProfileResponse.dart';
import '../responsemodel/MainPagePart/MainPageResponse.dart';
import '../responsemodel/ProductByCategoryIdResponse.dart';
import '../responsemodel/ProductResponse.dart';
import '../responsemodel/Login&RegisterResponse/RegisterResponse.dart';
import '../responsemodel/ShopKeeperResponsePart/EditShopKeeperResponse.dart';
import '../responsemodel/ShopKeeperResponsePart/ShopKeeperRequestResponse.dart';
import '../responsemodel/ShopKeeperResponsePart/ShopKeeperResponse.dart';
import '../responsemodel/ShopKeeperResponsePart/ShopProductListResponse.dart';
import '../responsemodel/TownshipsPart/AddTownshipResponse.dart';
import '../responsemodel/TownshipsPart/AllTownshipResponse.dart';
import '../responsemodel/TownshipsPart/EditTownshipResponse.dart';
import '../responsemodel/TownshipsPart/TownshipByCityIdResponse.dart';
import '../responsemodel/UserRoleResponse.dart';
import '../responsemodel/WarehousePart/WarehouseResponse.dart';
import '../responsemodel/common/ProductListItemResponse.dart';

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
      if (response.statusCode == 200) {
        final RegisterResponse data = RegisterResponse.fromJson(response.data);
        return data;
      } else {
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

  // Company Profile Data
  Future<CompanyProfileResponse> companyProfile() async {
    try {
      final Response response = await _dio.get(
        'https://mmeasyinvoice.com/api/profile'
      );

      if (response.statusCode == 200) {
        final CompanyProfileResponse data = CompanyProfileResponse.fromJson(response.data);
        return data;
      } else {
        throw DioError(
          requestOptions: RequestOptions(path: '/api/profile'),
          response: response,
        );
      }
    } catch (error) {
      throw DioError(
        requestOptions: RequestOptions(path: '/api/profile'),
        error: error,
      );
    }
  }

  //Edit company profile detail
  Future<EditCompanyProfileResponse> editCompanyProfile(EditCompanyProfileRequestModel editProfileRequestModel, int id) async {
    try {

      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/edit-profile/$id',
        data: editProfileRequestModel.toFormData(),
      );
      print("Update company profile status code is ${response.statusCode}");
      if (response.statusCode == 200) {
        final EditCompanyProfileResponse data = EditCompanyProfileResponse.fromJson(response.data);
        return data;
      } else {

        throw DioError(
          requestOptions: RequestOptions(path: '/api/edit-profile'),
          response: response,
        );
      }
    } catch (error) {
      print("response error is $error");
      throw DioError(
        requestOptions: RequestOptions(path: '/api/edit-profile'),
        error: error,
      );

    }
  }



  //add request for faulty items
  Future<AddFaultyItemResponse> addRequestFaultyItem(
      AddFaultyItemRequest addFaultyItemRequst) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/add-faulty-item',
        data: addFaultyItemRequst.toJson(),
      );
      if (response.statusCode == 200) {
        final AddFaultyItemResponse data =
            AddFaultyItemResponse.fromJson(response.data);
        return data;
      } else {
        throw DioError(
          requestOptions: RequestOptions(path: '/api/add-faulty-item'),
          response: response,
        );
      }
    } catch (error) {
      throw DioError(
        requestOptions: RequestOptions(path: '/api/add-faulty-item'),
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
        final RequestCountryResponse data =
            RequestCountryResponse.fromJson(response.data);
        return data;
      } else {
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
  Future<EditCountryResponse> editCountry(
      int id, EditCountry editCountry) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/edit-country/$id',
        data: editCountry.toJson(),
      );
      if (response.statusCode == 200) {
        final EditCountryResponse data =
            EditCountryResponse.fromJson(response.data);
        return data;
      } else {
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
  Future<EditCityResponse> editCity(int id, EditCity editCity) async {
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

  //edit township response
  Future<EditTownshipResponse> editTownship(
      int id, EditTownship editTownship) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/edit-township/$id',
        data: editTownship.toJson(),
      );
      if (response.statusCode == 200) {
        final EditTownshipResponse data =
            EditTownshipResponse.fromJson(response.data);
        return data;
      } else {
        throw DioError(
          requestOptions: RequestOptions(path: '/api/edit-township'),
          response: response,
        );
      }
    } catch (error) {
      throw DioError(
        requestOptions: RequestOptions(path: '/api/edit-township'),
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

  //choose product for order
  Future<ChooseProductOrderResponse> chooseProductOrder(
      ChooseProductOrderRequest productOrderRequest,
      ) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/chooseProduct',
        data: productOrderRequest.toJson(),
      );
      if (response.statusCode == 200) {
        final ChooseProductOrderResponse data =
        ChooseProductOrderResponse.fromJson(response.data);
        return data;
      } else {
        throw DioError(
          requestOptions: RequestOptions(path: '/api/chooseProduct'),
          response: response,
        );
      }
    } catch (error) {
      throw DioError(
        requestOptions: RequestOptions(path: '/api/chooseProduct'),
        error: error,
      );
    }
  }

  // fetch request township response
  Future<AddTownshipResponse> requestTownship(AddTownship addTownship) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/add-township',
        data: addTownship.toJson(),
      );
      if (response.statusCode == 200) {
        final AddTownshipResponse data =
            AddTownshipResponse.fromJson(response.data);
        return data;
      } else {
        throw DioError(
          requestOptions: RequestOptions(path: '/api/add-township'),
          response: response,
        );
      }
    } catch (error) {
      throw DioError(
        requestOptions: RequestOptions(path: '/api/add-township'),
        error: error,
      );
    }
  }

  // add delivery company name
  Future<AddDeliveryResponse> AddDelivery(
      AddDeliveryRequestModel addDeliveryRequestModel) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/add-delivery-companyname',
        data: addDeliveryRequestModel.toFormData(),
      );
      if (response.statusCode == 200) {
        final AddDeliveryResponse data =
            AddDeliveryResponse.fromJson(response.data);
        return data;
      } else {
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

  //change order quantity
  Future<ChangeOrderQtyResponse> changeOrderQty(
      ChangeOrderProductQtyRequest changeOrderProductQty,
      ) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/changeOrderProductQty',
        data: changeOrderProductQty.toJson(),
      );


      if (response.statusCode == 200) {
        final ChangeOrderQtyResponse data =
        ChangeOrderQtyResponse.fromJson(response.data);
        return data;
      } else {
        throw DioError(
          requestOptions: RequestOptions(path: '/api/changeOrderProductQty'),
          response: response,
        );
      }
    } catch (error) {
      throw DioError(
        requestOptions: RequestOptions(path: '/api/changeOrderProductQty'),
        error: error,
      );
    }
  }

  // product invoice
  Future<ProductInvoiceResponse> productInvoice(
      ProductInvoiceRequest productInvoiceRequest) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/barcodescan',
        data: productInvoiceRequest.toJson(),
      );

      if (response.statusCode == 200) {
        final ProductInvoiceResponse data =
        ProductInvoiceResponse.fromJson(response.data);
        return data;
      }

      else {
        throw DioError(
          requestOptions: RequestOptions(path: '/api/barcodescan'),
          response: response,
        );
      }
    } catch (error) {
      throw DioError(
        requestOptions: RequestOptions(path: '/api/add-order'),
        error: error,
      );
    }
  }

  // add order
  Future<AddOrderResponse> addOrder(
      AddOrderRequestModel addOrderRequest) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/add-order',
        data: addOrderRequest.toJson(),
      );
      if (response.statusCode == 200) {
        final AddOrderResponse data =
        AddOrderResponse.fromJson(response.data);
        return data;
      } else {
        throw DioError(
          requestOptions: RequestOptions(path: '/api/add-order'),
          response: response,
        );
      }
    } catch (error) {
      throw DioError(
        requestOptions: RequestOptions(path: '/api/add-order'),
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

  //Update shopkeeper
  Future<EditResponse> editShopKeeper(
      EditRequestModel editShopKeeperRequestModel , int id) async {
    try {
      final Response response = await _dio.post(
          'https://www.mmeasyinvoice.com/api/edit-shopkeeper/$id',
          data: editShopKeeperRequestModel.toJson());

      if (response.statusCode == 200) {
        final EditResponse updateShopKeeperResponse =
        EditResponse.fromJson(response.data);
        return updateShopKeeperResponse;
      } else {
        throw DioError(
          requestOptions: RequestOptions(path: '/api/edit-shopkeeper/$id'),
          response: response,
        );
      }
    } catch (error) {
      throw DioError(
        requestOptions: RequestOptions(path: '/api/edit-shopkeeper/$id'),
        error: error,
      );
    }
  }


  //Update faulty item
  Future<EditResponse> editFaulty(
      EditRequestModel editRequestModel , int id) async {
    try {
      final Response response = await _dio.post(
          'https://www.mmeasyinvoice.com/api/edit-faulty-item/$id',
          data: editRequestModel.toJson());

      if (response.statusCode == 200) {
        final EditResponse updateFaultyResponse =
        EditResponse.fromJson(response.data);
        return updateFaultyResponse;
      } else {
        throw DioError(
          requestOptions: RequestOptions(path: '/api/edit-faulty-item/$id'),
          response: response,
        );
      }
    } catch (error) {
      throw DioError(
        requestOptions: RequestOptions(path: '/api/edit-faulty-item/$id'),
        error: error,
      );
    }
  }
//Receive product form delivery man
  Future<DeliveryWarehouseResponse> deliverWarehouseRequest() async {
    try {
      int currentPage = 1;
      DeliveryWarehouseData deliveryWarehouseData;
      List<DeliveryWarehouseItem> allDeliveryItem = [];

      while (true) {
        final response = await _dio
            .get('https://mmeasyinvoice.com/api/delivered-warehouse-request?page=$currentPage');


        if (response.statusCode == 200) {
          final dynamic responseData = response.data;

          final deliveryDataResponse =
          DeliveryWarehouseResponse.fromJson(responseData);
          deliveryWarehouseData = deliveryDataResponse.data;
          final List<DeliveryWarehouseItem> deliveryItems = deliveryWarehouseData.data;
          allDeliveryItem.addAll(deliveryItems);

          if (currentPage == deliveryWarehouseData.last_page) {
            break;
          } else {
            currentPage++;
          }
        } else {
          throw Exception('Failed to fetch data');
        }
      }

      return DeliveryWarehouseResponse(
        data: DeliveryWarehouseData(
          current_page: currentPage,
          data: allDeliveryItem,
          first_page_url: 'https://mmeasyinvoice.com/api/delivered-warehouse-request?page=1',
          from: 1,
          last_page: currentPage,
          last_page_url:
          'https://mmeasyinvoice.com/api/delivered-warehouse-request?page=$currentPage',
          links: [],
          next_page_url: (currentPage < deliveryWarehouseData.last_page)
              ? 'https://mmeasyinvoice.com/api/delivered-warehouse-request?page=${currentPage + 1}'
              : '',
          path: 'https://mmeasyinvoice.com/api/delivered-warehouse-request',
          per_page: allDeliveryItem.length,
          prev_page_url: (currentPage > 1)
              ? 'https://mmeasyinvoice.com/api/delivered-warehouse-request?page=${currentPage - 1}'
              : null,
          to: allDeliveryItem.length,
          total: 0,
        ),
      );
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
// fetch all deliveries
  Future<FetchAllDelivery> fetchAllDelivery() async {
    try {
      int currentPage = 1;
      DeliveriesData deliveryData;
      List<DeliveriesItem> allDeliveryItem = [];

      while (true) {
        final response = await _dio
            .get('https://mmeasyinvoice.com/api/all-deliveries?page=$currentPage');


        if (response.statusCode == 200) {
          final dynamic responseData = response.data;

          final deliveryDataResponse =
          FetchAllDelivery.fromJson(responseData);
          deliveryData = deliveryDataResponse.data;
          final List<DeliveriesItem> deliveryItems = deliveryData.data;
          allDeliveryItem.addAll(deliveryItems);

          if (currentPage == deliveryData.last_page) {
            break;
          } else {
            currentPage++;
          }
        } else {
          throw Exception('Failed to fetch data');
        }
      }

      return FetchAllDelivery(
        data: DeliveriesData(
          current_page: currentPage,
          data: allDeliveryItem,
          first_page_url: 'https://mmeasyinvoice.com/api/all-deliveries?page=1',
          from: 1,
          last_page: currentPage,
          last_page_url:
          'https://mmeasyinvoice.com/api/all-deliveries?page=$currentPage',
          links: [],
          next_page_url: (currentPage < deliveryData.last_page)
              ? 'https://mmeasyinvoice.com/api/all-deliveries?page=${currentPage + 1}'
              : '',
          path: 'https://mmeasyinvoice.com/api/all-deliveries',
          per_page: allDeliveryItem.length,
          prev_page_url: (currentPage > 1)
              ? 'https://mmeasyinvoice.com/api/all-deliveries?page=${currentPage - 1}'
              : null,
          to: allDeliveryItem.length,
          total: 0,
        ),
      );
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }


  //fetch all category
  Future<PaginationDataResponse> getAllCategories() async {
    try {
      int currentPage = 1;
      PaginationData categoryData;
      List<PaginationItem> allCategories = [];

      while (true) {
        final response = await _dio
            .get('https://mmeasyinvoice.com/api/categories?page=$currentPage');

        if (response.statusCode == 200) {
          final dynamic responseData = response.data;

          final categoryDataResponse =
          PaginationDataResponse.fromJson(responseData);
          categoryData = categoryDataResponse.data;
          final List<PaginationItem> categories = categoryData.data;
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

      return PaginationDataResponse(
        data: PaginationData(
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
  // fetch all faulty item
  Future<AllFaultyItemsResponse> fetchAllFaultyItem() async {
    try {
      int currentPage = 1;
      FaultyDatas faultyData;
      List<FaultyItemData> faultyItemDatas = [];

      while (true) {
        final response = await _dio
            .get('https://mmeasyinvoice.com/api/faulty-item?page=$currentPage');

        if (response.statusCode == 200) {
          final dynamic responseData = response.data;

          final faultyDataResponse =
              AllFaultyItemsResponse.fromJson(responseData);
          faultyData = faultyDataResponse.data;
          final List<FaultyItemData> faultyItems = faultyData.data;
          faultyItemDatas.addAll(faultyItems);

          if (currentPage == faultyData.last_page) {
            break;
          } else {
            currentPage++;
          }
        } else {
          throw Exception('Failed to fetch faulty items');
        }
      }

      return AllFaultyItemsResponse(
        data: FaultyDatas(
          current_page: faultyData.current_page,
          data: faultyItemDatas,
          first_page_url: faultyData.first_page_url,
          from: faultyData.from,
          last_page: faultyData.last_page,
          last_page_url: faultyData.last_page_url,
          next_page_url: faultyData.next_page_url,
          path: faultyData.path,
          per_page: faultyData.per_page,
          prev_page_url: faultyData.prev_page_url,
          to: faultyData.to,
          total: faultyData.total,
          links: faultyData.links, // Adjusted 'link' to 'links'
        ),
        status: 200,
        message: "Successfully retrieved",
      );
    } catch (e) {
      throw Exception('Failed to fetch all faulty items: $e');
    }
  }

  // fetch all warehouse request from delivery man
  Future<DeliveryManResponse> fetchAllWarehouseRequest() async {
    try {
      int currentPage = 1;
      DeliveryData deliveryData;
      List<DeliveryItemData> deliveryItemsData = [];

      while (true) {
        final response = await _dio.get('https://www.mmeasyinvoice.com/api/received-warehouse-request?page=$currentPage');

        if (response.statusCode == 200) {
          final dynamic responseData = response.data;

          final deliveryManResponse =
          DeliveryManResponse.fromJson(responseData);
          deliveryData = deliveryManResponse.data;
          final List<DeliveryItemData> deliveryItemData = deliveryData.data;
          deliveryItemsData.addAll(deliveryItemData);

          if (currentPage == deliveryData.last_page) {
            break;
          } else {
            currentPage++;
          }
        } else {
          throw Exception('Failed to fetch delivery man response');
        }
      }

      return DeliveryManResponse(
        data: DeliveryData(
          current_page: currentPage,
          data: deliveryItemsData,
          first_page_url: 'https://mmeasyinvoice.com/api/received-warehouse-request?page=1',
          from: 1,
          last_page: currentPage,
          last_page_url:
          'https://mmeasyinvoice.com/api/received-warehouse-request?page=$currentPage',
          links: [],
          next_page_url: (currentPage < deliveryData.last_page)
              ? 'https://mmeasyinvoice.com/api/received-warehouse-request?page=${currentPage + 1}'
              : '',
          path: 'https://mmeasyinvoice.com/api/received-warehouse-request',
          per_page: deliveryItemsData.length,
          prev_page_url: (currentPage > 1)
              ? 'https://mmeasyinvoice.com/api/received-warehouse-request?page=${currentPage - 1}'
              : null,
          to: deliveryItemsData.length,
          total: 0,
        ),
      );
    } catch (e) {
      throw Exception('Failed to fetch delivery man response: $e');
    }
  }

  //Main Page for order filter
  Future<OrderApiResponse> orderFilter(String filterType) async {
    try {
      final Response response = await _dio.get(
        'https://mmeasyinvoice.com/api/filter-orders/$filterType',
      );
      if (response.statusCode == 200) {
        final OrderApiResponse orderApiResponse =
        OrderApiResponse.fromJson(response.data);
        return orderApiResponse;
      } else {
        throw DioError(
          requestOptions: RequestOptions(path: '/api/filter-orders/$filterType'),
          response: response,
        );
      }
    } catch (error) {

      throw DioError(
        requestOptions: RequestOptions(path: '/api/filter-orders/$filterType'),
        error: error,

      );
    }
  }


  //fetch all shop product list
  Future<ShopProductListResponse> shopProductList() async {
    try {
      int currentPage = 1;
      ShopProductList shopProductList;
      List<ShopProductItem> shopProductItemList = [];

      while (true) {
        final response = await _dio
            .get('https://mmeasyinvoice.com/api/show-shopkeeper?page=$currentPage');

        if (response.statusCode == 200) {
          final dynamic responseData = response.data;

          final shopProductListResponse =
          ShopProductListResponse.fromJson(responseData);
          shopProductList = shopProductListResponse.data;
          final List<ShopProductItem> shopProductItem = shopProductList.data;
          shopProductItemList.addAll(shopProductItem);

          if (currentPage == shopProductList.last_page) {
            break;
          } else {
            currentPage++;
          }
        } else {
          throw Exception('Failed to fetch shop product list.');
        }
      }

      return ShopProductListResponse(
        data: ShopProductList(
          current_page: currentPage,
          data: shopProductItemList,
          first_page_url: 'https://mmeasyinvoice.com/api/show-shopkeeper?page=1',
          from: 1,
          last_page: currentPage,
          last_page_url:
          'https://mmeasyinvoice.com/api/show-shopkeeper?page=$currentPage',
          links: [],
          next_page_url: (currentPage < shopProductList.last_page)
              ? 'https://mmeasyinvoice.com/api/show-shopkeeper?page=${currentPage + 1}'
              : '',
          path: 'https://mmeasyinvoice.com/api/show-shopkeeper',
          per_page: shopProductItemList.length,
          prev_page_url: (currentPage > 1)
              ? 'https://mmeasyinvoice.com/api/show-shopkeeper?page=${currentPage - 1}'
              : null,
          to: shopProductItemList.length,
          total: 0,
        ),
      );
    } catch (e) {
      throw Exception('Failed to fetch shop product list: $e');
    }
  }

  //shopkeeper request list
  Future<ShopKeeperRequestResponse> shopKeeperRequestList() async {
    try {
      final response = await _dio.get('https://mmeasyinvoice.com/api/shopkeeper-request');

      if (response.statusCode == 200) {
        final responseData = response.data;
        final shopkeeperRequestList = ShopKeeperRequestResponse.fromJson(responseData);

        return shopkeeperRequestList; // Return the actual shopkeeperRequestList object
      } else {
        throw Exception('Invalid data format for shopkeeper-request');
      }
    } catch (e) {
      throw Exception('Failed to fetch shopkeeper-request: $e');
    }
  }



  // Fetch all townships from the database
  Future<TownshipResponse> townships() async {
    try {
      int currentPage = 1;
      TownshipData? townshipData;
      List<Township> townshipItems = [];

      while (true) {
        final response = await _dio.post(
            'https://www.mmeasyinvoice.com/api/townships?page=$currentPage');
        if (response.statusCode == 200) {
          final dynamic responseData = response.data;
          final townships = TownshipResponse.fromJson(responseData);
          townshipData = townships.data;

          final List<Township> townshipItem = townshipData.data;
          townshipItems.addAll(townshipItem);

          if (currentPage == townshipData.lastPage) {
            break;
          } else {
            currentPage++;
          }
        } else {
          throw Exception('Failed to fetch townships');
        }
      }

      if (townshipData == null) {
        throw Exception('No township data found');
      }

      return TownshipResponse(
        data: TownshipData(
          currentPage: townshipData.currentPage,
          data: townshipItems,
          firstPageUrl: 'https://mmeasyinvoice.com/api/townships?page=1',
          lastPage: townshipData.lastPage,
          lastPageUrl:
              'https://mmeasyinvoice.com/api/townships?page=${townshipData.lastPage}',
          links: townshipData.links,
          nextPageUrl: (currentPage < townshipData.lastPage)
              ? 'https://mmeasyinvoice.com/api/townships?page=${currentPage + 1}'
              : null,
          path: 'https://www.mmeasyinvoice.com/api/townships',
          perPage: townshipData.perPage,
          prevPageUrl: (currentPage > 1)
              ? 'https://mmeasyinvoice.com/api/townships?page=${currentPage - 1}'
              : null,
          to: townshipData.to,
          total: townshipData.total,
          from: townshipData.from,
        ),
        status: 200,
        message: 'All Township are Retrieved Successfully!',
      );
    } catch (e) {
      throw Exception('Failed to fetch townships: $e');
    }
  }

  //fetch all city from db
  Future<CityResponse> cities() async {
    try {
      int currentPage = 1;
      CityData? cityData; // Change to nullable type
      List<City> cityItems = [];

      while (true) {
        final response = await _dio
            .get('https://mmeasyinvoice.com/api/cities?page=$currentPage');

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
          lastPageUrl:
              'https://mmeasyinvoice.com/api/cities?page=${cityData.lastPage}',
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

  //fetch all warehouse product list
  Future<WarehouseResponse> fetchWarehouseProductList() async {
    try {
      final response = await _dio.get('https://mmeasyinvoice.com/api/warehouse');

      if (response.statusCode == 200) {
        final responseData = response.data;
        final warehouseResponse = WarehouseResponse.fromJson(responseData);

        return warehouseResponse; // Return the actual warehouseResponse object
      } else {
        throw Exception('Invalid data format for warehouse');
      }
    } catch (e) {
      throw Exception('Failed to fetch warehouse: $e');
    }
  }


  //fetch all country from db
  Future<CountryResponse> country() async {
    try {
      int currentPage = 1;
      CountryData? countryData; // Change to nullable type
      List<Country> countryItems = [];

      while (true) {
        final response = await _dio
            .get('https://mmeasyinvoice.com/api/countries?page=$currentPage');

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
          lastPageUrl:
              'https://mmeasyinvoice.com/api/countries?page=${countryData.lastPage}',
          links: countryData.links,
          nextPageUrl: (currentPage < countryData.lastPage)
              ? 'https://mmeasyinvoice.com/api/countries?page=${currentPage + 1}'
              : null,
          from: 1,
          path: '',
          perPage: countryItems.length,
          prevPageUrl: '',
          to: countryItems.length,
          total: 0,
        ),
        status: 200,
        message: 'Success',
      );
    } catch (e) {
      throw Exception('Failed to fetch countries: $e');
    }
  }

  //fetch all product by category Id from db
  Future<List<ProductListItem>> fetchAllProductByCateId(int id) async {
    try {
      final response = await _dio
          .get('https://mmeasyinvoice.com/api/productByCategoryId/$id');

      if (response.statusCode == 200) {
        final responseData = response.data;
        final productByCategoryIdResponse =
            ProductByCategoryIdResponse.fromJson(responseData);

        return productByCategoryIdResponse.data;
      } else {
        throw Exception('Invalid data format for category by id field');
      }
    } catch (e) {
      throw Exception('Failed to fetch product role: $e');
    }
  }

  //fetch updated quantity barcode response
  Future<List<UpdateQuantity>> updatedQuantityItemBarcode(UpdateQuantityBarcodeRequest updateBarcodeRequest) async {
    try {
      final response = await _dio.post('https://mmeasyinvoice.com/api/update-product-quantity', data: updateBarcodeRequest.toJson());
      if (response.statusCode == 200) {
        final responseData = response.data;
        final updateQuantityList = (responseData['data'] as List)
            .map((item) => UpdateQuantity.fromJson(item))
            .toList();
        return updateQuantityList;
      } else {
        throw Exception('Invalid data format for updated quantity in barcode scan field');
      }
    } catch (e) {
      throw Exception('Failed to fetch updated quantity in barcode scan: $e');
    }
  }

  //fetch all cities by country Id
  Future<List<CityByCountryIdData>> fetchAllCitiesByCountryId(int id) async {
    try {
      final response = await _dio
          .get('https://mmeasyinvoice.com/api/cities-by-countryid/$id');
      if (response.statusCode == 200) {
        final responseData = response.data;
        final cityByCountryIdResponse =
            CityByCountryIdResponse.fromJson(responseData);
        return cityByCountryIdResponse.data;
      } else {
        throw Exception('Invalid data format for city by country id field');
      }
    } catch (e) {
      throw Exception('Failed to fetch city by country id : $e');
    }
  }

  //fetch all township by city Id
  Future<List<TownshipByCityIdData>> fetchAllTownshipByCityId(int id) async {
    try {
      final response = await _dio
          .get('https://mmeasyinvoice.com/api/townships-by-cityid/$id');
      if (response.statusCode == 200) {
        final responseData = response.data;
        final townshipByCityIdResponse =
        TownshipByCityIdResponse.fromJson(responseData);
        return townshipByCityIdResponse.data;
      } else {
        throw Exception('Invalid data format for township by city id field');
      }
    } catch (e) {
      throw Exception('Failed to fetch township by city id : $e');
    }
  }

  //fetch all delivery company name
  Future<List<AllDeliveryName>> fetchAllDeliveryCompanyName() async {
    try {
      final response =
          await _dio.get('https://mmeasyinvoice.com/api/companynames');
      if (response.statusCode == 200) {
        final responseData = response.data;
        final fetchAllDeliveryName =
            FetchAllDeliveryName.fromJson(responseData);
        return fetchAllDeliveryName.allDeliveryName;
      } else {
        throw Exception('Invalid data format for delivery company name field');
      }
    } catch (e) {
      throw Exception('Failed to fetch delivery company name: $e');
    }
  }

  //fetch all company name by township Id
  Future<List<CompanyData>> fetchAllCompanyByTownshipId(int id) async {
    try {
      final response = await _dio
          .get('https://mmeasyinvoice.com/api/deliveryCompany/$id');
      if (response.statusCode == 200) {
        final responseData = response.data;
        final fetchAllCompanyByTownshipId =
        DeliveryCompanyResponse.fromJson(responseData);
        return fetchAllCompanyByTownshipId.companyData;
      } else {
        throw Exception('Invalid data format for fetch company by township id field');
      }
    } catch (e) {
      throw Exception('Failed to fetch company by township id : $e');
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
  Future<PaginationDataResponse> getAllSizes() async {
    try {
      int currentPage = 1;
      PaginationData sizeData;
      List<PaginationItem> allSizes = [];

      while (true) {
        final response = await _dio
            .get('https://mmeasyinvoice.com/api/sizes?page=$currentPage');

        if (response.statusCode == 200) {
          final dynamic responseData = response.data;

          final sizeDataResponse = PaginationDataResponse.fromJson(responseData);

          sizeData = sizeDataResponse.data;
          final List<PaginationItem> sizes = sizeData.data;
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

      return PaginationDataResponse(
        data: PaginationData(
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
        final response = await _dio
            .get('https://mmeasyinvoice.com/api/users?page=$currentPage');

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
        total: 0,
        // You can set the correct value for the total number of users
        status: 200,
        // Set the appropriate status code
        message: 'Success', // Set the appropriate message
      );
    } catch (e) {
      throw Exception('Failed to fetch user roles: $e');
    }
  }

  //Delete category by id

  Future<DeleteResponse> deleteCategory(int id) async {
    try {
      final response =
          await _dio.post('https://mmeasyinvoice.com/api/delete-category/$id');
      if (response.statusCode == 200) {
        DeleteResponse deleteCategory = DeleteResponse.fromJson(response.data);
        return deleteCategory;
      } else {
        throw Exception('Something wrong!');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  //Delete country by id

  Future<DeleteResponse> deleteCountry(int id) async {
    try {
      final response =
          await _dio.post('https://mmeasyinvoice.com/api/delete-country/$id');
      if (response.statusCode == 200) {
        DeleteResponse deleteCountry =
            DeleteResponse.fromJson(response.data);
        return deleteCountry;
      } else {
        throw Exception('Something wrong!');
      }
    } catch (error) {
      throw Exception(error);
    }
  }
  //Delete Faulty item by id
  Future<DeleteResponse> deleteFaulty(int id) async {
    try {
      final response =
      await _dio.post('https://mmeasyinvoice.com/api/delete-faulty-item/$id');
    print("$response");

      if (response.statusCode == 200) {
        DeleteResponse deleteFaulty =
        DeleteResponse.fromJson(response.data);
        return deleteFaulty;
      } else {
        throw Exception('Something wrong!');
      }
    } catch (error) {
      throw Exception(error);
    }
  }




  //Delete city by id
  Future<DeleteResponse> deleteCity(int id) async {
    try {
      final response =
          await _dio.post('https://mmeasyinvoice.com/api/delete-city/$id');
      if (response.statusCode == 200) {
        DeleteResponse deleteCity =
            DeleteResponse.fromJson(response.data);
        return deleteCity;
      } else {
        throw Exception('Something wrong!');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  //Delete delivery by id

  Future<DeleteResponse> deleteDelivery(int id) async {
    try {
      final response =
      await _dio.post('https://mmeasyinvoice.com/api/delete-delivery/$id');
      if (response.statusCode == 200) {
        DeleteResponse deleteDelivery =
        DeleteResponse.fromJson(response.data);
        return deleteDelivery;
      } else {
        throw Exception('Something wrong!');
      }
    } catch (error) {
      throw Exception(error);
    }
  }



  //Delete shopkeeper request product by id
  Future<DeleteResponse> deleteShopKeeperRequestProduct(int id) async {
    try {
      final response =
      await _dio.post('https://mmeasyinvoice.com/api/delete-shopkeeper/$id');
      if (response.statusCode == 200) {
        DeleteResponse deleteShopKeeperRequestProduct =
        DeleteResponse.fromJson(response.data);
        return deleteShopKeeperRequestProduct;
      } else {
        throw Exception('Something wrong!');
      }
    } catch (error) {
      throw Exception(error);
    }
  }



  //Delete township by id
  Future<DeleteResponse> deleteTownship(int id) async {
    try {
      final response =
          await _dio.post('https://mmeasyinvoice.com/api/delete-township/$id');
      if (response.statusCode == 200) {
        DeleteResponse deleteTownship =
            DeleteResponse.fromJson(response.data);
        return deleteTownship;
      } else {
        throw Exception('Something wrong!');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  //Delete product by id

  Future<DeleteResponse> deleteProductItem(int id) async {
    try {
      final response =
          await _dio.post('https://mmeasyinvoice.com/api/delete-product/$id');
      //  print("Delete Product status response is ${response.statusCode}");
      if (response.statusCode == 200) {
        DeleteResponse deleteProductResponse =
            DeleteResponse.fromJson(response.data);
        return deleteProductResponse;
      } else {
        throw Exception('Something wrong!');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

   //to delete size
  Future<DeleteResponse> deleteSize(int id) async {
    try {
      final response =
          await _dio.post('https://mmeasyinvoice.com/api/delete-size/$id');
      // print("Delete Size status response is ${response.statusCode}");
      if (response.statusCode == 200) {
        DeleteResponse deleteSize =
           DeleteResponse.fromJson(response.data);
        return deleteSize;
      } else {
        throw Exception('Something wrong!');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  //to update category by id
  Future<UpdateResponse> updateCategory(
      EditCategory editCategory, int id) async {
    try {
      final response = await _dio.post(
          'https://mmeasyinvoice.com/api/edit-category/$id',
          data: editCategory.toJson());
      if (response.statusCode == 200) {
        UpdateResponse categoryUpdateResponse =
            UpdateResponse.fromJson(response.data);

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
  Future<UpdateResponse> updateSize(EditSize editSize, int id) async {
    try {
      final response = await _dio.post(
          'https://mmeasyinvoice.com/api/edit-size/$id',
          data: editSize.toJson());
      if (response.statusCode == 200) {
        UpdateResponse sizeUpdateResponse =
            UpdateResponse.fromJson(response.data);

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
      if (response.statusCode == 200) {
        final UserResponse data = UserResponse.fromJson(response.data);
        return data;
      } else {
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
  Future<DeleteResponse> deleteUserRole(int id) async {
    try {
      final response =
          await _dio.post('https://mmeasyinvoice.com/api/delete-user/$id');
      if (response.statusCode == 200) {
        DeleteResponse deleteUserRoleResponse =
            DeleteResponse.fromJson(response.data);
        return deleteUserRoleResponse;
      } else {
        throw Exception('Something wrong!');
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
