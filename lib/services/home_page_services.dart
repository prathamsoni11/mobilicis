import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobilicis/models/deals_filter_model.dart';
import 'package:mobilicis/models/deals_model.dart';
import 'package:mobilicis/models/search_model.dart';

class HomePageServices {
  Future<DealsModel?> fetchBestDeals() async {
    DealsModel? dealsModel;
    try {
      int page = 1;
      int limit = 10;
      String url =
          "https://dev2be.oruphones.com/api/v1/global/assignment/getListings?page=$page&limit=$limit";
      final response = await http.get(Uri.parse(url));
      dealsModel = DealsModel.fromJson(await jsonDecode(response.body));
    } catch (e) {
      print('Error Occurred $e');
    }

    return dealsModel;
  }

  Future<DealsFilterModel?> fetchFilters({isLimited = true}) async {
    DealsFilterModel? dealsFilterModel;
    try {
      String url =
          "https://dev2be.oruphones.com/api/v1/global/assignment/getFilters?isLimited=$isLimited";
      final response = await http.get(Uri.parse(url));
      dealsFilterModel =
          DealsFilterModel.fromJson(await jsonDecode(response.body));
    } catch (e) {
      print('Error Occurred $e');
    }

    return dealsFilterModel;
  }

  Future<SearchModel?> searchPost(String searchText) async {
    SearchModel? searchModel;
    try {
      String url =
          "https://dev2be.oruphones.com/api/v1/global/assignment/searchModel";
      Map<String, String> headers = {"Content-type": "application/json"};
      Map<String, String> body = {
        'searchModel': searchText,
      };
      var response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(body));
      searchModel = SearchModel.fromJson(await jsonDecode(response.body));
    } catch (e) {
      print('Error Occurred $e');
    }

    return searchModel;
  }
}
