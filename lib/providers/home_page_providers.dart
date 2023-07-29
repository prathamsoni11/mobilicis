import 'package:flutter/material.dart';
import 'package:mobilicis/models/deals_filter_model.dart';
import 'package:mobilicis/models/deals_model.dart';
import 'package:mobilicis/models/search_model.dart';
import 'package:mobilicis/services/home_page_services.dart';

class HomePageProviders extends ChangeNotifier {
  DealsModel? _dealsModel;
  DealsFilterModel? _dealsFilterModel;
  SearchModel? _searchModel;

  final HomePageServices _homePageServices = HomePageServices();

  getDealsData() async {
    _dealsModel = await _homePageServices.fetchBestDeals();
    notifyListeners();
  }

  getDealsFilters() async {
    _dealsFilterModel = await _homePageServices.fetchFilters();
    notifyListeners();
  }

  getSearchResult(String searchText) async {
    _searchModel = await _homePageServices.searchPost(searchText);
    notifyListeners();
  }

  SearchModel? get searchModel => _searchModel;
  DealsModel? get dealsModel => _dealsModel;
  DealsFilterModel? get dealsFilterModel => _dealsFilterModel;
}
