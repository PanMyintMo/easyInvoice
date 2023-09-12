import 'package:easy_invoice/data/responsemodel/CityPart/Cities.dart';

import '../data/api/apiService.dart';
import '../data/responsemodel/CityPart/Wards.dart';
import '../data/responsemodel/CountryPart/CountryResponse.dart';
import '../data/responsemodel/FaultyItemPart/AllFaultyItems.dart';
import '../data/responsemodel/GetAllPagnitaionDataResponse.dart';
import '../data/responsemodel/TownshipsPart/AllTownshipResponse.dart';
import '../data/responsemodel/common/ProductListItemResponse.dart';

class ApiHelper {
  //By using static , you can call directly apiHelper.fetchCategoryName like that
  static Future<List<PaginationItem>?> fetchCategoriesName() async {
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
  static Future<List<PaginationItem>?> fetchSizeName() async {
    try {
      final response = await ApiService().getAllSizes();
      if (response.data.isNotEmpty) {
        return response.data;
      }
    } catch (error) {
      print('Error fetching sizes: $error');
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
      print('Error fetching city: $error');
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
      print('Error fetching township: $error');
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
      print('Error fetching country: $error');
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
      print('Error fetching wards: $error');
    }
    return []; // Return an empty list if the request fails
  }



  //fetch all product

  static Future<List<ProductListItem>?> fetchAllProductItem() async {
    try {
      final response = await ApiService().fetchAllProducts();
      if (response.data.isNotEmpty) {
        return response.data;
      }
    } catch (error) {
      print('Error fetching product: $error');
    }
    return [];
  }

  //fetch all faultyItem

  static Future<List<FaultyItemData>> fetchAllFaultyItem() async {
    try {
      final response = await ApiService().fetchAllFaultyItem();
      if (response.data.isNotEmpty) {
        return response.data;
      }
    } catch (error) {
      print('Error fetching faulty item: $error');
    }
    return [];
  }
}
