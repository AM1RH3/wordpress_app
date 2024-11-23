import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:woedpress_app/api/api_service.dart';
import 'package:woedpress_app/models/woocommerce/product_model.dart';
import 'package:woedpress_app/ui/catalog/catalog_widget/sort_class.dart';

enum DataStatus {
  initial,
  loading,
  stable,
}

class CatalogProvider with ChangeNotifier {
  late APIService _apiService;
  late List<Product> _productList;
  late SortBy _sortBy;
  int page = 1;

  int pageSize = 7;
  DataStatus _dataStatus = DataStatus.stable;

  List<Product> get allProduct => _productList;
  double get totalProducts => _productList.length.toDouble();

  initializeData() {
    _apiService = APIService();
    _productList = <Product>[];
  }

  CatalogProvider() {
    initializeData();
    _sortBy = SortBy('popularity', 'Latest', 'asc');
  }

  getDataStatus() => _dataStatus;

  setLoadingState(DataStatus dataStatus) {
    _dataStatus = dataStatus;
    notifyListeners();
  }

  setSortOrder(SortBy sortBy) {
    _sortBy = sortBy;
    notifyListeners();
  }

  fetchProducts(
    pageNumber, {
    String? searchKeyword,
    String? tagName,
    String? sortBy,
    String? sortOrder = 'desc',
  }) async {
    List<Product> itemModel = await _apiService.getCatalog(
      searchKeyword: searchKeyword,
      tagName: tagName,
      pageNumber: pageNumber,
      pageSize: pageSize,
      sortBy: _sortBy.value,
      sortOrder: _sortBy.sortOrder.toString(),
    );
    if (itemModel.isNotEmpty) {
      _productList.addAll(itemModel);
    }
    setLoadingState(DataStatus.stable);
    notifyListeners();
  }
}
