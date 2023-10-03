import 'dart:developer';

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
import '../../dataRequestModel/CityPart/AddStreetRequestModel.dart';
import '../../dataRequestModel/CityPart/AddWardRequestModel.dart';
import '../../dataRequestModel/CityPart/EditCity.dart';
import '../../dataRequestModel/CountryPart/AddCountry.dart';
import '../../dataRequestModel/CountryPart/EditCountry.dart';
import '../../dataRequestModel/DeliveryPart/AddDeliveryCompanyInfoRequestModel.dart';
import '../../dataRequestModel/DeliveryPart/AddDeliveryCompanyNameRequestModel.dart';
import '../../dataRequestModel/DeliveryPart/AddOrderRequestModel.dart';
import '../../dataRequestModel/DeliveryPart/ChangeOrderProductQty.dart';
import '../../dataRequestModel/DeliveryPart/ChangeOrderStatusRequestModel.dart';
import '../../dataRequestModel/DeliveryPart/ChooseProductForOrderRequestModel.dart';
import '../../dataRequestModel/DeliveryPart/EditOrderDetailRequestModel.dart';
import '../../dataRequestModel/DeliveryPart/OrderByDateRequestModel.dart';
import '../../dataRequestModel/DeliveryPart/ProductInvoiceRequest.dart';
import '../../dataRequestModel/DeliveryPart/UpdateDeliveryRequestModel.dart';
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
import '../../widget/ProviceInvoicePart/InvoiceResponse/Invoice.dart';
import '../responsemodel/AddCategoryResponseModel.dart';
import '../responsemodel/CityPart/AddCityResponse.dart';
import '../responsemodel/CityPart/AddStreetResponse.dart';
import '../responsemodel/CityPart/AddWardResponse.dart';
import '../responsemodel/CityPart/Cities.dart';
import '../responsemodel/CityPart/EditWardResponse.dart';
import '../responsemodel/CityPart/Street.dart';
import '../responsemodel/CityPart/StreetByWardIdResponse.dart';
import '../responsemodel/CityPart/WardByTownshipResponse.dart';
import '../responsemodel/CityPart/Wards.dart';
import '../responsemodel/DeliveryPart/DeliveryCompanyInfoResponse.dart';
import '../responsemodel/DeliveryPart/FetchAllDeliveries.dart';
import '../responsemodel/DeliveryPart/FetchAllOrderByDate.dart';
import '../responsemodel/DeliveryPart/OrderDetailResponse.dart';
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
import '../responsemodel/common/WardResponse.dart';

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
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
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
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
    }
  }

  // Company Profile Data
  Future<CompanyProfileResponse> companyProfile() async {
    try {
      final Response response =
          await _dio.get('https://mmeasyinvoice.com/api/profile');

      if (response.statusCode == 200) {
        final CompanyProfileResponse data =
            CompanyProfileResponse.fromJson(response.data);
        return data;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
    }
  }


  //Invoice
  Future<Invoice> generate() async {
    try {
      final Response response =
      await _dio.get('https://mmeasyinvoice.com/api/invoice');

      if (response.statusCode == 200) {
        final Invoice data =
        Invoice.fromJson(response.data);
        return data;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
    }
  }


  //Edit company profile detail
  Future<EditCompanyProfileResponse> editCompanyProfile(
      EditCompanyProfileRequestModel editProfileRequestModel, int id) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/edit-profile/$id',
        data: editProfileRequestModel.toFormData(),
      );
      //print("Update company profile status code is ${response.statusCode}");
      if (response.statusCode == 200) {
        final EditCompanyProfileResponse data =
            EditCompanyProfileResponse.fromJson(response.data);
        return data;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
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
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
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
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
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
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
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
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
    }
  }

  //edit Ward response
  Future<EditWardResponse> editWard(
      int id, AddWardRequestModel editWardRequestModel) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/edit-ward/$id',
        data: editWardRequestModel.toJson(),
      );
      if (response.statusCode == 200) {
        final EditWardResponse data = EditWardResponse.fromJson(response.data);
        return data;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
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
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
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
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
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
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
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
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
    }
  }

  // add delivery company name
  Future<AddDeliveryResponse> addDelivery(
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
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
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
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
    }
  }

  // product invoice for barcode scan
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
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
    }
  }

  // add order
  Future<OrderResponse> addOrder(AddOrderRequestModel addOrderRequest) async {
    try {
      final Response response = await _dio.post(
        'https://www.mmeasyinvoice.com/api/add-order',
        data: addOrderRequest.toJson(),
      );
      //print("order response are :${response}");

      if (response.statusCode == 200) {
        final OrderResponse data = OrderResponse.fromJson(response.data);
        return data;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data $error');
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
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
    }
  }

  //Add product
  Future<ProductResponse> addProduct(
      AddProductRequestModel addProductRequestModel) async {
    try {
      final Response response = await _dio.post(
          'https://mmeasyinvoice.com/api/add-product',
          data: addProductRequestModel.toFormData());

      if (response.statusCode == 200) {
        final ProductResponse addProductResponseData =
            ProductResponse.fromJson(response.data);
        return addProductResponseData;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
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
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
    }
  }

  //Update shopkeeper
  Future<EditResponse> editShopKeeper(
      EditRequestModel editShopKeeperRequestModel, int id) async {
    try {
      final Response response = await _dio.post(
          'https://www.mmeasyinvoice.com/api/edit-shopkeeper/$id',
          data: editShopKeeperRequestModel.toJson());

      if (response.statusCode == 200) {
        final EditResponse updateShopKeeperResponse =
            EditResponse.fromJson(response.data);
        return updateShopKeeperResponse;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
    }
  }

  //company delivery info
  Future<DeliCompanyInfoResponse> deliCompanyInfo(AddDeliCompanyInfoRequest addDeliCompanyInfoRequest) async {
    try {
      final Response response = await _dio.post(
          'https://www.mmeasyinvoice.com/api/add-delivery-info',data: addDeliCompanyInfoRequest
         );

      if (response.statusCode == 200) {
        final DeliCompanyInfoResponse deliCompanyResponse =
        DeliCompanyInfoResponse.fromJson(response.data);
        return deliCompanyResponse;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
    }
  }


  //Update faulty item
  Future<EditResponse> editFaulty(
      EditRequestModel editRequestModel, int id) async {
    try {
      final Response response = await _dio.post(
          'https://www.mmeasyinvoice.com/api/edit-faulty-item/$id',
          data: editRequestModel.toJson());

      if (response.statusCode == 200) {
        final EditResponse updateFaultyResponse =
            EditResponse.fromJson(response.data);
        return updateFaultyResponse;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
    }
  }

//Receive product form delivery man
  Future<DeliveryWarehouseResponse> deliverWarehouseRequest() async {
    try {
      int currentPage = 1;
      DeliveryWarehouseData deliveryWarehouseData;
      List<DeliveryWarehouseItem> allDeliveryItem = [];

      while (true) {
        final response = await _dio.get(
            'https://mmeasyinvoice.com/api/delivered-warehouse-request?page=$currentPage');

        if (response.statusCode == 200) {
          final dynamic responseData = response.data;

          final deliveryDataResponse =
              DeliveryWarehouseResponse.fromJson(responseData);
          deliveryWarehouseData = deliveryDataResponse.data;
          final List<DeliveryWarehouseItem> deliveryItems =
              deliveryWarehouseData.data;
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
          first_page_url:
              'https://mmeasyinvoice.com/api/delivered-warehouse-request?page=1',
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
      List<DeliveriesItem> deliveryItemData = [];
      String? nextPageUrl;

      while (true) {
        final response = await _dio.get(
            'https://www.mmeasyinvoice.com/api/all-deliveries?page=$currentPage');

        if (response.statusCode == 200) {
          final dynamic responseData = response.data;

          final allDeliveryResponse = FetchAllDelivery.fromJson(responseData);
          final deliveryData = allDeliveryResponse.data;

          deliveryItemData.addAll(deliveryData);

          nextPageUrl = allDeliveryResponse.next_page_url;

          if (currentPage == allDeliveryResponse.last_page) {
            break;
          } else {
            currentPage++;
          }
        } else {
          throw Exception('Failed to fetch all faulty date.');
        }
      }

      return FetchAllDelivery(
        current_page: currentPage,
        data: deliveryItemData,
        first_page_url: 'https://mmeasyinvoice.com/api/all-deliveries?page=1',
        from: 1,
        // Always set to 1 if data is not empty
        last_page: currentPage,
        last_page_url:
            'https://mmeasyinvoice.com/api/all-deliveries?page=$currentPage',
        links: [],
        next_page_url: nextPageUrl,
        path: 'https://mmeasyinvoice.com/api/faulty-item',
        per_page: deliveryItemData.length,
        prev_page_url: (currentPage > 1)
            ? 'https://mmeasyinvoice.com/api/all-deliveries?page=${currentPage - 1}'
            : null,
        to: 1,
        total: 0,
        status: null,
        // You can set this to null or provide the appropriate value
        message:
            null, // You can set this to null or provide the appropriate value
      );
    } catch (e) {
      throw Exception('Failed to fetch delivery by date response: $e');
    }
  }

  //fetch all category

  Future<PaginationDataResponse> getAllCategories() async {
    try {
      int currentPage = 1;
      List<PaginationItem> categoryData = [];
      String? nextPageUrl;

      while (true) {
        final response = await _dio
            .get('https://mmeasyinvoice.com/api/categories?page=$currentPage');

        if (response.statusCode == 200) {
          final dynamic responseData = response.data;

          final cateResponse = PaginationDataResponse.fromJson(responseData);
          final cateData = cateResponse.data;

          categoryData.addAll(cateData);

          nextPageUrl = cateResponse.nextPageUrl;

          if (currentPage == cateResponse.lastPage) {
            break;
          } else {
            currentPage++;
          }
        } else {
          throw Exception('Failed to fetch all category date.');
        }
      }

      return PaginationDataResponse(
        currentPage: currentPage,
        data: categoryData,
        firstPageUrl: 'https://mmeasyinvoice.com/api/categories?page=1',
        from: 1,
        // Always set to 1 if data is not empty
        lastPage: currentPage,
        lastPageUrl:
            'https://mmeasyinvoice.com/api/categories?page=$currentPage',
        links: [],
        nextPageUrl: nextPageUrl,
        path: 'https://mmeasyinvoice.com/api/categories',
        perPage: categoryData.length,
        prevPageUrl: (currentPage > 1)
            ? 'https://mmeasyinvoice.com/api/categories?page=${currentPage - 1}'
            : null,
        to: 1,
        total: 0,
        status: null,
        message: null,
      );
    } catch (e) {
      throw Exception('Failed to fetch category by date response: $e');
    }
  }

  // fetch all faulty item
  Future<AllFaultyItemsResponse> fetchAllFaultyItem() async {
    try {
      int currentPage = 1;
      List<FaultyItemData> faultyItemData = [];
      String? nextPageUrl;

      while (true) {
        final response = await _dio.get(
            'https://www.mmeasyinvoice.com/api/faulty-item?page=$currentPage');

        if (response.statusCode == 200) {
          final dynamic responseData = response.data;

          final faultyItemResponse =
              AllFaultyItemsResponse.fromJson(responseData);
          final faultyData = faultyItemResponse.data;

          faultyItemData.addAll(faultyData);

          nextPageUrl = faultyItemResponse.nextPageUrl;

          if (currentPage == faultyItemResponse.lastPage) {
            break;
          } else {
            currentPage++;
          }
        } else {
          throw Exception('Failed to fetch all faulty date.');
        }
      }

      return AllFaultyItemsResponse(
        currentPage: currentPage,
        data: faultyItemData,
        firstPageUrl: 'https://mmeasyinvoice.com/api/ordersByDate?page=1',
        from: 1,
        // Always set to 1 if data is not empty
        lastPage: currentPage,
        lastPageUrl:
            'https://mmeasyinvoice.com/api/ordersByDate?page=$currentPage',
        links: [],
        nextPageUrl: nextPageUrl,
        path: 'https://mmeasyinvoice.com/api/ordersByDate',
        perPage: faultyItemData.length,
        prevPageUrl: (currentPage > 1)
            ? 'https://mmeasyinvoice.com/api/ordersByDate?page=${currentPage - 1}'
            : null,
        to: 1,
        total: 0,
        status: null,
        // You can set this to null or provide the appropriate value
        message:
            null, // You can set this to null or provide the appropriate value
      );
    } catch (e) {
      throw Exception('Failed to fetch orders by date response: $e');
    }
  }

  //fetch all country from db
  Future<CountryResponse> country() async {
    try {
      int currentPage = 1;
      List<Country> countryData = [];
      String? nextPageUrl;

      while (true) {
        final response = await _dio
            .get('https://mmeasyinvoice.com/api/countries?page=$currentPage');

        if (response.statusCode == 200) {
          final dynamic responseData = response.data;

          final countryResponse = CountryResponse.fromJson(responseData);
          final countryItem = countryResponse.data;

          countryData.addAll(countryItem);

          nextPageUrl = countryResponse.nextPageUrl;

          if (currentPage == countryResponse.lastPage) {
            break;
          } else {
            currentPage++;
          }
        } else {
          throw Exception('Failed to fetch all country.');
        }
      }

      return CountryResponse(
        currentPage: currentPage,
        data: countryData,
        firstPageUrl: 'https://mmeasyinvoice.com/api/countries?page=1',
        from: 1,
        // Always set to 1 if data is not empty
        lastPage: currentPage,
        lastPageUrl:
            'https://mmeasyinvoice.com/api/countries?page=$currentPage',
        links: [],
        nextPageUrl: nextPageUrl,
        path: 'https://mmeasyinvoice.com/api/countries',
        perPage: countryData.length,
        prevPageUrl: (currentPage > 1)
            ? 'https://mmeasyinvoice.com/api/countries?page=${currentPage - 1}'
            : null,
        to: 1,
        total: 0,
        status: null,
        // You can set this to null or provide the appropriate value
        message:
            null, // You can set this to null or provide the appropriate value
      );
    } catch (e) {
      throw Exception('Failed to fetch country response: $e');
    }
  }

  //fetch all city from db
  Future<CityResponse> cities() async {
    try {
      int currentPage = 1;
      List<City> cityData = [];
      String? nextPageUrl;

      while (true) {
        final response = await _dio
            .get('https://mmeasyinvoice.com/api/cities?page=$currentPage');

        if (response.statusCode == 200) {
          final dynamic responseData = response.data;

          final cityResponse = CityResponse.fromJson(responseData);
          final cityItem = cityResponse.data;

          cityData.addAll(cityItem);

          nextPageUrl = cityResponse.nextPageUrl;

          if (currentPage == cityResponse.lastPage) {
            break;
          } else {
            currentPage++;
          }
        } else {
          throw Exception('Failed to fetch all city.');
        }
      }

      return CityResponse(
        currentPage: currentPage,
        data: cityData,
        firstPageUrl: 'https://mmeasyinvoice.com/api/cities?page=1',
        from: 1,
        // Always set to 1 if data is not empty
        lastPage: currentPage,
        lastPageUrl: 'https://mmeasyinvoice.com/api/cities?page=$currentPage',
        links: [],
        nextPageUrl: nextPageUrl,
        path: 'https://mmeasyinvoice.com/api/cities',
        perPage: cityData.length,
        prevPageUrl: (currentPage > 1)
            ? 'https://mmeasyinvoice.com/api/cities?page=${currentPage - 1}'
            : null,
        to: 1,
        total: 0,
        status: null,
        // You can set this to null or provide the appropriate value
        message:
            null, // You can set this to null or provide the appropriate value
      );
    } catch (e) {
      throw Exception('Failed to fetch city response: $e');
    }
  }

  //fetch all ward from db
  Future<WardResponse> wards() async {
    try {
      int currentPage = 1;
      List<Ward> wrapData = [];
      String? nextPageUrl;

      while (true) {
        final response = await _dio
            .get('https://mmeasyinvoice.com/api/wards?page=$currentPage');

        if (response.statusCode == 200) {
          final dynamic responseData = response.data;

          final wardResponse = WardResponse.fromJson(responseData);
          final wrapItem = wardResponse.data;

          wrapData.addAll(wrapItem);

          nextPageUrl = wardResponse.next_page_url;

          if (currentPage == wardResponse.last_page) {
            break;
          } else {
            currentPage++;
          }
        } else {
          throw Exception('Failed to fetch all wards.');
        }
      }

      return WardResponse(
        current_page: currentPage,
        data: wrapData,
        first_page_url: 'https://mmeasyinvoice.com/api/wards?page=1',
        from: 1,
        // Always set to 1 if data is not empty
        last_page: currentPage,
        last_page_url: 'https://mmeasyinvoice.com/api/wards?page=$currentPage',
        links: [],
        next_page_url: nextPageUrl,
        path: 'https://mmeasyinvoice.com/api/wards',
        per_page: wrapData.length,
        prev_page_url: (currentPage > 1)
            ? 'https://mmeasyinvoice.com/api/wards?page=${currentPage - 1}'
            : null,
        to: 1,
        total: 0,
        status: null,
        // You can set this to null or provide the appropriate value
        message:
            null, // You can set this to null or provide the appropriate value
      );
    } catch (e) {
      throw Exception('Failed to fetch wards response: $e');
    }
  }

  //fetch all street from db
  Future<StreetResponse> streets() async {
    try {
      int currentPage = 1;
      List<Street> streetData = [];
      String? nextPageUrl;

      while (true) {
        final response = await _dio
            .get('https://mmeasyinvoice.com/api/streets?page=$currentPage');

        if (response.statusCode == 200) {
          final dynamic responseData = response.data;

          final streetResponse = StreetResponse.fromJson(responseData);
          final streetItem = streetResponse.data;

          streetData.addAll(streetItem);

          nextPageUrl = streetResponse.nextPageUrl;

          if (currentPage == streetResponse.lastPage) {
            break;
          } else {
            currentPage++;
          }
        } else {
          throw Exception('Failed to fetch all wards.');
        }
      }

      return StreetResponse(
        currentPage: currentPage,
        data: streetData,
        firstPageUrl: 'https://mmeasyinvoice.com/api/streets?page=1',
        from: 1,
        // Always set to 1 if data is not empty
        lastPage: currentPage,
        lastPageUrl: 'https://mmeasyinvoice.com/api/streets?page=$currentPage',
        links: [],
        nextPageUrl: nextPageUrl,
        path: 'https://mmeasyinvoice.com/api/streets',
        perPage: streetData.length,
        prevPageUrl: (currentPage > 1)
            ? 'https://mmeasyinvoice.com/api/streets?page=${currentPage - 1}'
            : null,
        to: 1,
        total: 0,
        status: null,
        // You can set this to null or provide the appropriate value
        message:
            null, // You can set this to null or provide the appropriate value
      );
    } catch (e) {
      throw Exception('Failed to fetch streets response: $e');
    }
  }

  // Fetch all townships from the database
  Future<TownshipResponse> townships() async {
    try {
      int currentPage = 1;
      List<Township> townshipData = [];
      String? nextPageUrl;

      while (true) {
        final response = await _dio.get(
            'https://www.mmeasyinvoice.com/api/townships?page=$currentPage');

        if (response.statusCode == 200) {
          final dynamic responseData = response.data;

          final townshipResponse = TownshipResponse.fromJson(responseData);
          final townshipItem = townshipResponse.data;

          townshipData.addAll(townshipItem);

          nextPageUrl = townshipResponse.nextPageUrl;

          if (currentPage == townshipResponse.lastPage) {
            break;
          } else {
            currentPage++;
          }
        } else {
          throw Exception('Failed to fetch all township.');
        }
      }

      return TownshipResponse(
        currentPage: currentPage,
        data: townshipData,
        firstPageUrl: 'https://mmeasyinvoice.com/api/townships?page=1',
        from: 1,
        // Always set to 1 if data is not empty
        lastPage: currentPage,
        lastPageUrl:
            'https://mmeasyinvoice.com/api/townships?page=$currentPage',
        links: [],
        nextPageUrl: nextPageUrl,
        path: 'https://mmeasyinvoice.com/api/township',
        perPage: townshipData.length,
        prevPageUrl: (currentPage > 1)
            ? 'https://mmeasyinvoice.com/api/townships?page=${currentPage - 1}'
            : null,
        to: 1,
        total: 0,
        status: null,
        // You can set this to null or provide the appropriate value
        message:
            null, // You can set this to null or provide the appropriate value
      );
    } catch (e) {
      throw Exception('Failed to fetch township response: $e');
    }
  }

  // fetch all warehouse request from delivery man
  Future<DeliveryManResponse> fetchAllWarehouseRequest() async {
    try {
      int currentPage = 1;
      DeliveryData deliveryData;
      List<DeliveryItemData> deliveryItemsData = [];

      while (true) {
        final response = await _dio.get(
            'https://www.mmeasyinvoice.com/api/received-warehouse-request?page=$currentPage');

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
          first_page_url:
              'https://mmeasyinvoice.com/api/received-warehouse-request?page=1',
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
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data $error');
    }
  }

  //fetch all order detail
  Future<OrderDetailResponse> fetchOrderDetail(int id) async {
    try {
      final Response response = await _dio.get(
        'https://mmeasyinvoice.com/api/orderdetails/$id',
      );

      print("Order detail response are : $response");
      if (response.statusCode == 200) {
        final OrderDetailResponse orderApiResponse =
            OrderDetailResponse.fromJson(response.data);
        return orderApiResponse;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
    }
  }

  //fetch edit order detail response
  Future<OrderResponse> editOrderDetail(
      int id, EditOrderDetailRequestModel editOrderDetailRequestModel) async {
    try {
      final Response response = await _dio.post(
          'https://mmeasyinvoice.com/api/update-order/$id',
          data: editOrderDetailRequestModel.toJson());


      if (response.statusCode == 200) {
        final OrderResponse orderApiResponse =
        OrderResponse.fromJson(response.data);
        return orderApiResponse;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data $error');
    }
  }

  //fetch all shop product list
  Future<ShopProductListResponse> shopProductList() async {
    try {
      int currentPage = 1;
      ShopProductList shopProductList;
      List<ShopProductItem> shopProductItemList = [];

      while (true) {
        final response = await _dio.get(
            'https://mmeasyinvoice.com/api/show-shopkeeper?page=$currentPage');

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
          first_page_url:
              'https://mmeasyinvoice.com/api/show-shopkeeper?page=1',
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

  // fetch all order by date
  Future<OrderByDateResponse> fetchAllOrderByDate(
      OrderByDateRequest orderByDateRequestModel) async {
    try {
      int currentPage = 1;
      List<OrderDatas> orderFilterData = [];

      String? nextPageUrl;

      while (true) {
        final response = await _dio.post(
            'https://www.mmeasyinvoice.com/api/ordersByDate?page=$currentPage',
            data: orderByDateRequestModel.toJson());

        if (response.statusCode == 200) {
          final dynamic responseData = response.data;

          final orderByDateResponse =
              OrderByDateResponse.fromJson(responseData);
          final orderByDateData = orderByDateResponse.data;

          orderFilterData.addAll(orderByDateData);

          nextPageUrl = orderByDateResponse.nextPageUrl;

          if (currentPage == orderByDateResponse.lastPage) {
            break;
          } else {
            currentPage++;
          }
        } else {
          throw Exception('Failed to fetch all orders by date.');
        }
      }

      return OrderByDateResponse(
        currentPage: currentPage,
        data: orderFilterData,
        firstPageUrl: 'https://mmeasyinvoice.com/api/ordersByDate?page=1',
        from: 1,
        // Always set to 1 if data is not empty
        lastPage: currentPage,
        lastPageUrl:
            'https://mmeasyinvoice.com/api/ordersByDate?page=$currentPage',
        links: [],
        nextPageUrl: nextPageUrl,
        path: 'https://mmeasyinvoice.com/api/ordersByDate',
        perPage: orderFilterData.length,
        prevPageUrl: (currentPage > 1)
            ? 'https://mmeasyinvoice.com/api/ordersByDate?page=${currentPage - 1}'
            : null,
        to: 1,
        total: 0,
        status: null,
        // You can set this to null or provide the appropriate value
        message:
            null, // You can set this to null or provide the appropriate value
      );
    } catch (e) {
      throw Exception('Failed to fetch orders by date response: $e');
    }
  }

  //shopkeeper request list
  Future<ShopKeeperRequestResponse> shopKeeperRequestList() async {
    try {
      final response =
          await _dio.get('https://mmeasyinvoice.com/api/shopkeeper-request');

      if (response.statusCode == 200) {
        final responseData = response.data;
        final shopkeeperRequestList =
            ShopKeeperRequestResponse.fromJson(responseData);

        return shopkeeperRequestList; // Return the actual shopkeeperRequestList object
      } else {
        throw Exception('Invalid data format for shopkeeper-request');
      }
    } catch (e) {
      throw Exception('Failed to fetch shopkeeper-request: $e');
    }
  }

  //fetch all warehouse product list
  Future<WarehouseResponse> fetchWarehouseProductList() async {
    try {
      final response =
          await _dio.get('https://mmeasyinvoice.com/api/warehouse');

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
  Future <UpdateQuantity> updatedQuantityItemBarcode(
      UpdateQuantityBarcodeRequest updateBarcodeRequest) async {
    try {
      final response = await _dio.post(
          'https://mmeasyinvoice.com/api/update-product-quantity',
          data: updateBarcodeRequest.toJson());
      if (response.statusCode == 200) {
        final responseData = response.data;
        final updateQuantityBarcodeResponse =
        UpdateQuantityBarcodeResponse.fromJson(responseData);

        return updateQuantityBarcodeResponse.data;

      }
      else {
        throw Exception('Invalid data format for warehouse');
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

  //fetch all ward by township Id
  Future<List<WardByTownshipData>> fetchWardByTownship(int id) async {
    try {
      final response = await _dio
          .get('https://mmeasyinvoice.com/api/wards-by-townshipid/$id');
      //print("Fetch Ward By Township response are $response");

      log('wardByTownship : $response');

      if (response.statusCode == 200) {
        final responseData = response.data;
        final wardByTownshipResponse =
        WardByTownshipResponse.fromJson(responseData);
        return wardByTownshipResponse.data;
      } else {
        throw Exception('Invalid data format for ward by township id field');
      }
    } catch (e) {
      throw Exception('Failed to fetch ward by township id : $e');
    }
  }

  //update delivery by id
  Future<DeliCompanyInfoResponse> updateDeliveryById(int id,UpdateDeliveryRequestModel updateDeliveryRequestModel) async {
    try {
      final response =
      await _dio.post('https://mmeasyinvoice.com/api/edit-delivery/$id',data: updateDeliveryRequestModel);
      if (response.statusCode == 200) {
        final responseData = response.data;
        final updateDeliveryResponse =
        DeliCompanyInfoResponse.fromJson(responseData);
        return updateDeliveryResponse;
      } else {
        throw Exception('Invalid data format for update delivery id field');
      }
    } catch (e) {
      throw Exception('Failed to update delivery by  id : $e');
    }
  }




//fetch all street by ward Id
  Future<StreetByWardIdResponse> fetchStreetByWardId(int id) async {
    try {
      final response =
          await _dio.get('https://mmeasyinvoice.com/api/streets-by-wardid/$id');
      if (response.statusCode == 200) {
        final responseData = response.data;
        final streetByWardIdResponse =
            StreetByWardIdResponse.fromJson(responseData);
        return streetByWardIdResponse;
      } else {
        throw Exception('Invalid data format for ward by ward id field');
      }
    } catch (e) {
      throw Exception('Failed to fetch street by ward id : $e');
    }
  }

  //fetch all company name by township Id
  Future<List<CompanyData>> fetchAllCompanyByTownshipId(int id) async {
    try {
      final response =
          await _dio.get('https://mmeasyinvoice.com/api/deliveryCompany/$id');
      if (response.statusCode == 200) {
        final responseData = response.data;
        final fetchAllCompanyByTownshipId =
            DeliveryCompanyResponse.fromJson(responseData);
        return fetchAllCompanyByTownshipId.companyData;
      } else {
        throw Exception(
            'Invalid data format for fetch company by township id field');
      }
    } catch (e) {
      throw Exception('Failed to fetch company by township id : $e');
    }
  }

  //fetch all product from db
  Future<GetAllProductResponse> fetchAllProducts() async {
    try {
      int currentPage = 1;
      List<ProductListItem> productData = [];
      String? nextPageUrl;

      while (true) {
        final response = await _dio
            .get('https://mmeasyinvoice.com/api/products?page=$currentPage');

        if (response.statusCode == 200) {
          final dynamic responseData = response.data;

          final productResponse = GetAllProductResponse.fromJson(responseData);
          final productItemData = productResponse.data;

          productData.addAll(productItemData);

          nextPageUrl = productResponse.nextPageUrl;

          if (currentPage == productResponse.lastPage) {
            break;
          } else {
            currentPage++;
          }
        } else {
          throw Exception('Failed to fetch all product date.');
        }
      }

      return GetAllProductResponse(
        currentPage: currentPage,
        data: productData,
        firstPageUrl: 'https://mmeasyinvoice.com/api/products?page=1',
        from: 1,
        // Always set to 1 if data is not empty
        lastPage: currentPage,
        lastPageUrl: 'https://mmeasyinvoice.com/api/products?page=$currentPage',
        links: [],
        nextPageUrl: nextPageUrl,
        path: 'https://mmeasyinvoice.com/api/products',
        perPage: productData.length,
        prevPageUrl: (currentPage > 1)
            ? 'https://mmeasyinvoice.com/api/products?page=${currentPage - 1}'
            : null,
        to: 1,
        total: 0,
        status: null,
        message: null,
      );
    } catch (e) {
      throw Exception('Failed to fetch product  response: $e');
    }
  }

  //fetch all sizes from db
  Future<PaginationDataResponse> getAllSizes() async {
    try {
      int currentPage = 1;
      List<PaginationItem> sizeData = [];
      String? nextPageUrl;

      while (true) {
        final response = await _dio
            .get('https://mmeasyinvoice.com/api/sizes?page=$currentPage');

        if (response.statusCode == 200) {
          final dynamic responseData = response.data;

          final sizeResponse = PaginationDataResponse.fromJson(responseData);
          final sizeItemData = sizeResponse.data;

          sizeData.addAll(sizeItemData);

          nextPageUrl = sizeResponse.nextPageUrl;

          if (currentPage == sizeResponse.lastPage) {
            break;
          } else {
            currentPage++;
          }
        } else {
          throw Exception('Failed to fetch all sizes date.');
        }
      }

      return PaginationDataResponse(
        currentPage: currentPage,
        data: sizeData,
        firstPageUrl: 'https://mmeasyinvoice.com/api/sizes?page=1',
        from: 1,
        // Always set to 1 if data is not empty
        lastPage: currentPage,
        lastPageUrl: 'https://mmeasyinvoice.com/api/sizes?page=$currentPage',
        links: [],
        nextPageUrl: nextPageUrl,
        path: 'https://mmeasyinvoice.com/api/sizes',
        perPage: sizeData.length,
        prevPageUrl: (currentPage > 1)
            ? 'https://mmeasyinvoice.com/api/sizes?page=${currentPage - 1}'
            : null,
        to: 1,
        total: 0,
        status: null,
        message: null,
      );
    } catch (e) {
      throw Exception('Failed to fetch sizes  response: $e');
    }
  }

  //fetch all user role from db
  Future<UserRoleResponse> getAllUserRole() async {
    try {
      int currentPage = 1;
      List<UserData> userData = [];
      String? nextPageUrl;

      while (true) {
        final response = await _dio
            .get('https://mmeasyinvoice.com/api/users?page=$currentPage');

        if (response.statusCode == 200) {
          final dynamic responseData = response.data;

          final userResponse = UserRoleResponse.fromJson(responseData);
          final usersItem = userResponse.data;

          userData.addAll(usersItem);

          nextPageUrl = userResponse.nextPageUrl;

          if (currentPage == userResponse.lastPage) {
            break;
          } else {
            currentPage++;
          }
        } else {
          throw Exception('Failed to fetch all user.');
        }
      }

      return UserRoleResponse(
        currentPage: currentPage,
        data: userData,
        firstPageUrl: 'https://mmeasyinvoice.com/api/users?page=1',
        from: 1,
        // Always set to 1 if data is not empty
        lastPage: currentPage,
        lastPageUrl: 'https://mmeasyinvoice.com/api/users?page=$currentPage',
        links: [],
        nextPageUrl: nextPageUrl,
        path: 'https://mmeasyinvoice.com/api/products',
        perPage: userData.length,
        prevPageUrl: (currentPage > 1)
            ? 'https://mmeasyinvoice.com/api/users?page=${currentPage - 1}'
            : null,
        to: 1,
        total: 0,
        status: null,
        message: null,
      );
    } catch (e) {
      throw Exception('Failed to fetch all user response: $e');
    }
  }

  //warehouse manager status change

  Future<DeleteResponse> warehouseManagerStatus(int id) async {
    try {
      final response = await _dio.post(
          'https://mmeasyinvoice.com/api/warehouse-manager-update-status/$id');
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

  //Change order status
  Future<DeleteResponse> changeOrderStatus(ChangeOrderStatusRequestModel changeOrderStatusRequestModel) async {
    try {
      final response = await _dio.post(
          'https://mmeasyinvoice.com/api/changeStatus',data: changeOrderStatusRequestModel.toJson());
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

  //Delivery man status change

  Future<DeleteResponse> deliveryManStatus(int id) async {
    try {
      final response = await _dio
          .post('https://mmeasyinvoice.com/api/delivery-man-update-status/$id');
      if (response.statusCode == 200) {
        DeleteResponse deliverStatus = DeleteResponse.fromJson(response.data);
        return deliverStatus;
      } else {
        throw Exception('Something wrong!');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

//shopKeeper  status change

  Future<DeleteResponse> shopKeeperStatus(int id) async {
    try {
      final response = await _dio
          .post('https://mmeasyinvoice.com/api/shopkeeper-update-status/$id');
      if (response.statusCode == 200) {
        DeleteResponse shopkeeperStatus =
            DeleteResponse.fromJson(response.data);
        return shopkeeperStatus;
      } else {
        throw Exception('Something wrong!');
      }
    } catch (error) {
      throw Exception(error);
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
        DeleteResponse deleteCountry = DeleteResponse.fromJson(response.data);
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
      final response = await _dio
          .post('https://mmeasyinvoice.com/api/delete-faulty-item/$id');
      //print("$response");

      if (response.statusCode == 200) {
        DeleteResponse deleteFaulty = DeleteResponse.fromJson(response.data);
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
        DeleteResponse deleteCity = DeleteResponse.fromJson(response.data);
        return deleteCity;
      } else {
        throw Exception('Something wrong!');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  //Delete street by id
  Future<DeleteResponse> deleteStreet(int id) async {
    try {
      final response =
          await _dio.post('https://mmeasyinvoice.com/api/delete-street/$id');
      if (response.statusCode == 200) {
        DeleteResponse deleteStreet = DeleteResponse.fromJson(response.data);
        return deleteStreet;
      } else {
        throw Exception('Something wrong!');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  //Delete ward by id
  Future<DeleteResponse> deleteWard(int id) async {
    try {
      final response =
          await _dio.post('https://mmeasyinvoice.com/api/delete-ward/$id');
      if (response.statusCode == 200) {
        DeleteResponse deleteWard = DeleteResponse.fromJson(response.data);
        return deleteWard;
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
        DeleteResponse deleteDelivery = DeleteResponse.fromJson(response.data);
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
      final response = await _dio
          .post('https://mmeasyinvoice.com/api/delete-shopkeeper/$id');
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
        DeleteResponse deleteTownship = DeleteResponse.fromJson(response.data);
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
        DeleteResponse deleteSize = DeleteResponse.fromJson(response.data);
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
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
    }
  }

  // for add user role
  Future<UserResponse> user(UserRequestModel userRequestModel) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/add-user',
        data: userRequestModel.toFormData(),
      );
      if (response.statusCode == 200) {
        final UserResponse data = UserResponse.fromJson(response.data);
        return data;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
    }
  }

  // Edit User Role
  Future<EditUserRoleResponse> editUserRole(
      EditUserRoleRequestModel editUserRoleRequestModel, int id) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/edit-user/$id',
        data: editUserRoleRequestModel.toFormData(),
      );
      if (response.statusCode == 200) {
        final EditUserRoleResponse data =
            EditUserRoleResponse.fromJson(response.data);
        return data;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
    }
  }

  // for add ward
  Future<AddWardResponse> addWard(
      AddWardRequestModel addWardRequestModel) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/add-ward',
        data: addWardRequestModel.toJson(),
      );
      if (response.statusCode == 200) {
        final AddWardResponse data = AddWardResponse.fromJson(response.data);
        return data;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
    }
  }

// for add street
  Future<AddStreetResponse> addStreet(
      AddStreetRequestModel addStreetRequestModel) async {
    try {
      final Response response = await _dio.post(
        'https://mmeasyinvoice.com/api/add-street',
        data: addStreetRequestModel.toJson(),
      );
      if (response.statusCode == 200) {
        final AddStreetResponse data =
            AddStreetResponse.fromJson(response.data);
        return data;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data');
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
