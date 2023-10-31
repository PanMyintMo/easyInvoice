import '../data/api/ConnectivityService.dart';
import '../data/api/apiService.dart';
import '../data/responseModel/CityPart/Cities.dart';
import '../data/responseModel/CityPart/Street.dart';
import '../data/responseModel/CityPart/WardByTownshipResponse.dart';
import '../data/responseModel/CountryPart/CountryResponse.dart';
import '../data/responseModel/FaultyItemPart/AllFaultyItems.dart';
import '../data/responseModel/GetAllPaganizationDataResponse.dart';
import '../data/responseModel/ShopKeeperResponsePart/ShopProductListResponse.dart';
import '../data/responseModel/TownshipsPart/AllTownshipResponse.dart';
import '../data/responseModel/common/ProductListItemResponse.dart';
import '../data/responseModel/common/WardResponse.dart';

class ApiHelper {
  //By using static , you can call directly apiHelper.fetchCategoryName like that
  static Future<List<PaganizationItem>?> fetchCategoriesName() async {
    try {
      final response = await ApiService(ConnectivityService()).getAllCategories();
      if (response.data.isNotEmpty) {
        return response.data;
      }
    } catch (error) {
     //
    }
    return []; // Return an empty list if the request fails
  }

  //Fetch size Name
  static Future<List<PaganizationItem>?> fetchSizeName() async {
    try {
      final response = await ApiService(ConnectivityService()).getAllSizes();
      if (response.data.isNotEmpty) {
        return response.data;
      }
    } catch (error) {
    //
    }
    return []; // Return an empty list if the request fails
  }

  //Fetch city Name
  static Future<List<City>> fetchCityName() async {
    try {
      final response = await ApiService(ConnectivityService()).cities();
      if (response.data.isNotEmpty) {
        return response.data;
      }
    } catch (error) {
     //
    }
    return []; // Return an empty list if the request fails
  }

  //Fetch township Name
  static Future<List<Township>> fetchTownshipName() async {
    try {
      final response = await ApiService(ConnectivityService()).townships();
      if (response.data.isNotEmpty) {
        return response.data;
      }
    } catch (error) {
     //
    }
    return []; // Return an empty list if the request fails
  }

  //Fetch country Name
  static Future<List<Country>?> fetchCountryName() async {
    try {
      final response = await ApiService(ConnectivityService()).country();
      if (response.data.isNotEmpty) {
        return response.data;
      }
    } catch (error) {
    //
    }
    return []; // Return an empty list if the request fails
  }

  //Fetch ward Name
  static Future<List<Ward>?> fetchWardName() async {
    try {
      final response = await ApiService(ConnectivityService()).wards();
      if (response.data.isNotEmpty) {
        return response.data;
      }
    } catch (error) {
     //
    }
    return []; // Return an empty list if the request fails
  }

  //fetch ward by township id
  static Future<List<WardByTownshipData>> fetchWardByTownshipId(int id) async{
    try{
      final response= await ApiService(ConnectivityService()).fetchWardByTownship(id);
      if(response.isNotEmpty){
        return response;
      }

    }
    catch(error){
     //
    }
    return [];
  }
  //fetch street by ward id
  static Future<List<Street>> fetchStreetByWardId(int id) async{
    try{
      final response= await ApiService(ConnectivityService()).fetchStreetByWardId(id);
      if(response.data.isNotEmpty){
        return response.data;
      }
    }
    catch(error){
    //
    }
    return [];
  }

  //fetch all product

  static Future<List<ProductListItem>?> fetchAllProductItem() async {
    try {
      final response = await ApiService(ConnectivityService()).fetchAllProducts();
      if (response.data.isNotEmpty) {
        return response.data;
      }
    } catch (error) {
   //
    }
    return [];
  }

//fetch all shop's product list
  static Future<ShopProductListResponse?> allShopProduct() async {
    try {
      final response = await ApiService(ConnectivityService()).shopProductList();
      print("shop product list response are ${response}");

        return response;

    } catch (error) {
  //
    }
    return null;
  }

  //fetch all faultyItem

  static Future<List<FaultyItemData>> fetchAllFaultyItem() async {
    try {
      final response = await ApiService(ConnectivityService()).fetchAllFaultyItem();
      if (response.data.isNotEmpty) {
        return response.data;
      }
    } catch (error) {
     //
    }
    return [];
  }
}
