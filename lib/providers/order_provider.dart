import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:woedpress_app/api/api_service.dart';
import 'package:woedpress_app/models/woocommerce/order_model.dart';

class OrderProvider with ChangeNotifier {
  bool isLoading = false;
  late APIService _apiService;

  List<OrderModel>? _orderList;
  List<OrderModel>? get allorders => _orderList;
  double get totalOrders => _orderList!.length.toDouble();

  OrderProvider() {
    initializeData();
  }
  initializeData() {
    _apiService = APIService();
  }

  fetchOrders() async {
    isLoading = true;
    notifyListeners();
    List<OrderModel> orderList = await _apiService.getAllOrders();
    _orderList ??= <OrderModel>[];
    if (orderList.isNotEmpty) {
      _orderList = [];
      _orderList!.addAll(orderList);
    }
    isLoading = false;
    notifyListeners();
  }
}
