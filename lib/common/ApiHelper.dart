
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
      final response = await ApiService().getAllCategories();
      if (response.data.isNotEmpty) {
        return response.data;
      }
    } catch (error) {
      print('Error fetching categories: $error');
    }
    return []; // Return an empty list if the request fails
  }

  //Fetch size Name
  static Future<List<PaganizationItem>?> fetchSizeName() async {
    try {
      final response = await ApiService().getAllSizes();
      if (response.data.isNotEmpty) {
        return response.data;
      }
    } catch (error) {
     // print('Error fetching sizes: $error');
    }
    return []; // Return an empty list if the request fails
  }

  //Fetch city Name
  static Future<List<City>> fetchCityName() async {
    try {
      final response = await ApiService().cities();
      if (response.data.isNotEmpty) {
        return response.data;
      }
    } catch (error) {
     // print('Error fetching city: $error');
    }
    return []; // Return an empty list if the request fails
  }

  //Fetch township Name
  static Future<List<Township>> fetchTownshipName() async {
    try {
      final response = await ApiService().townships();
      if (response.data.isNotEmpty) {
        return response.data;
      }
    } catch (error) {
      //print('Error fetching township: $error');
    }
    return []; // Return an empty list if the request fails
  }

  //Fetch country Name
  static Future<List<Country>?> fetchCountryName() async {
    try {
      final response = await ApiService().country();
      if (response.data.isNotEmpty) {
        return response.data;
      }
    } catch (error) {
     // print('Error fetching country: $error');
    }
    return []; // Return an empty list if the request fails
  }

  //Fetch ward Name
  static Future<List<Ward>?> fetchWardName() async {
    try {
      final response = await ApiService().wards();
      if (response.data.isNotEmpty) {
        return response.data;
      }
    } catch (error) {
      //print('Error fetching wards: $error');
    }
    return []; // Return an empty list if the request fails
  }

  //fetch ward by township id
  static Future<List<WardByTownshipData>> fetchWardByTownshipId(int id) async{
    try{
      final response= await ApiService().fetchWardByTownship(id);
      if(response.isNotEmpty){
        return response;
      }
     // print("Ward list are ${response}");
    }
    catch(error){
      //print('Error is $error');
    }
    return [];
  }
  //fetch street by ward id
  static Future<List<Street>> fetchStreetByWardId(int id) async{
    try{
      final response= await ApiService().fetchStreetByWardId(id);
      if(response.data.isNotEmpty){
        return response.data;
      }
    }
    catch(error){
     // print('Error is $error');
    }
    return [];
  }

  //fetch all product

  static Future<List<ProductListItem>?> fetchAllProductItem() async {
    try {
      final response = await ApiService().fetchAllProducts();
      if (response.data.isNotEmpty) {
        return response.data;
      }
    } catch (error) {
     // print('Error fetching product: $error');
    }
    return [];
  }

//fetch all shop's product list
  static Future<ShopProductListResponse?> allShopProduct() async {
    try {
      final response = await ApiService().shopProductList();

        return response;

    } catch (error) {
     // print('Error fetching product: $error');
    }
    return null;
  }

  //fetch all faultyItem

  static Future<List<FaultyItemData>> fetchAllFaultyItem() async {
    try {
      final response = await ApiService().fetchAllFaultyItem();
      if (response.data.isNotEmpty) {
        return response.data;
      }
    } catch (error) {
     // print('Error fetching faulty item: $error');
    }
    return [];
  }
}
