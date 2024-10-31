import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:woedpress_app/api/api_service.dart';
import 'package:woedpress_app/db/secure_db.dart';
import 'package:woedpress_app/db/shared_pr_db.dart';
import 'package:woedpress_app/models/woocommerce/addtocart_request_model.dart';
import 'package:woedpress_app/models/woocommerce/cart_response_model.dart';
import 'package:woedpress_app/models/woocommerce/customer_details_model.dart';
import 'package:woedpress_app/models/woocommerce/order_model.dart';
import 'package:woedpress_app/models/woocommerce/product_category_model.dart';
import 'package:woedpress_app/models/woocommerce/product_model.dart';
import 'package:woedpress_app/models/wordpress/wordpress_post_model.dart';

class ShopProvider with ChangeNotifier {
  APIService? _apiService;

  ShopProvider() {
    _apiService = APIService();
    _itemsinCart = <CartItem>[];
  }

  bool isLoading = false;
  bool isLoadingPosts = false;
  bool isLoadingShippingDetails = false;
  int selectedIndex = 0;

  // for Store All Wordpress Posts
  List<WordpressPosts> _wordpressPosts = <WordpressPosts>[];
  List<WordpressPosts> get wordpressPosts => _wordpressPosts;

  // for Store All Category names
  List<ProductCategory> _productCategory = <ProductCategory>[];
  List<ProductCategory> get productCategory => _productCategory;

  // for Store Products with Category name
  List<Product> _productByCategory = <Product>[];
  List<Product> get productByCategory => _productByCategory;

  // items in shopping Cart
  List<CartItem>? _itemsinCart;
  List<CartItem>? get itemsinCart => _itemsinCart;

  // get Customer Details
  CustomerDetailsModel? _customerDetailsModel;
  CustomerDetailsModel? get customerDetailsModel => _customerDetailsModel;

  // create order
  OrderModel? _orderModel;
  OrderModel get orderModel => _orderModel!;

  // check if order created or not
  bool _isOrderCreated = false;
  bool get isOrderCreated => _isOrderCreated;

  // sum of items in the shopping Cart
  double? get totalRecords => _itemsinCart!.length.toDouble();

  // sum of price in the Shopping Cart
  double? get totalAmount => _itemsinCart != null
      ? _itemsinCart!.map<double?>((e) => e.lineSubtotal).reduce(
            (value, element) => value! + element!,
          )
      : 0;
// NABEGHEHA.COM
  Future<void> getAllWordpressPosts() async {
    isLoadingPosts = true;
    notifyListeners();
    final List<WordpressPosts> postResponse = await _apiService!.getPosts();
    _wordpressPosts = postResponse;
    isLoadingPosts = false;
    notifyListeners();
  }

  Future<void> getAllCategoryNames() async {
    isLoading = true;
    notifyListeners();
    final List<ProductCategory> categoryResponse =
        await _apiService!.getProductCategory();
    _productCategory = categoryResponse;
    isLoading = false;
    notifyListeners();
  }

  Future<void> getProductsByCategory(String categoryID) async {
    isLoading = true;
    notifyListeners();
    final List<Product> productByCategoryResponse =
        await _apiService!.getProductCategorybyID(categoryID);
    _productByCategory = productByCategoryResponse;
    isLoading = false;
    notifyListeners();
  }

  Future<void> addToCart(CartProducts product, Function onCallBack) async {
    AddtoCartReqModel reqModel = AddtoCartReqModel();
    reqModel.products = <CartProducts>[];

    if (_itemsinCart == null) initializeData();

    for (var element in _itemsinCart!) {
      reqModel.products!.add(
        CartProducts(productId: element.productId, quantity: element.quantity),
      );
    }
    CartProducts? duplicatedProductID = reqModel.products!.firstWhereOrNull(
      (prod) => prod.productId == product.productId,
    );
    if (duplicatedProductID != null) {
      reqModel.products!.remove(duplicatedProductID);
    }
    reqModel.products!.add(product);

    await _apiService!.addtoCart(reqModel).then(
      (carResModel) {
        if (carResModel.data != null) {
          List<CartItem>? newCartResModel = carResModel.data;
          _itemsinCart = [];
          _itemsinCart!.addAll(newCartResModel!);
        }
        onCallBack(carResModel);
        notifyListeners();
      },
    );
  }

// NABEGHEHA.COM
  Future<void> fetchCartItems() async {
    bool isLoggedin = await SecureSorageDB().isLoggedin();
    if (_itemsinCart == null) initializeData();
    if (isLoggedin) {
      await _apiService?.getCartItems().then(
        (cartResModel) {
          if (cartResModel.data!.isNotEmpty) {
            _itemsinCart!.clear();
            List<CartItem>? newCartResModel = cartResModel.data;
            _itemsinCart!.addAll(newCartResModel!);
          }
        },
      );
    }
  }

  void updateQty(int productID, int newQty) {
    CartItem? isProductExist =
        _itemsinCart!.firstWhereOrNull((prd) => prd.productId == productID);
    if (isProductExist != null) {
      isProductExist.quantity = newQty;
    }
    notifyListeners();
  }

  void removeItem(int productID) {
    CartItem? isProductExist =
        _itemsinCart!.firstWhereOrNull((prd) => prd.productId == productID);
    if (isProductExist != null) {
      _itemsinCart!.remove(isProductExist);
    }
    notifyListeners();
  }

  Future<void> updateCart(Function onCallback) async {
    AddtoCartReqModel reqModel = AddtoCartReqModel();
    reqModel.products = <CartProducts>[];

    if (_itemsinCart == null) initializeData();

    _itemsinCart?.forEach((element) {
      reqModel.products!.add(CartProducts(
        productId: element.productId,
        quantity: element.quantity,
      ));
    });

    await _apiService!.addtoCart(reqModel).then((cartResModel) {
      if (cartResModel.data != null) {
        List<CartItem>? newCartResModel = cartResModel.data;
        _itemsinCart = [];
        _itemsinCart!.addAll(newCartResModel!);
      }
      onCallback(cartResModel);
      notifyListeners();
    });
  }

  Future<void> resetCart(Function onCallback) async {
    AddtoCartReqModel reqModel = AddtoCartReqModel();
    reqModel.products = <CartProducts>[];

    if (_itemsinCart == null) initializeData();

    _itemsinCart?.forEach((element) {
      reqModel.products!.add(CartProducts(
        productId: element.productId,
        quantity: 0,
      ));
    });

    await _apiService!.addtoCart(reqModel).then((cartResModel) {
      if (cartResModel.data != null) {
        List<CartItem>? newCartResModel = cartResModel.data;
        _itemsinCart = [];
        _itemsinCart!.addAll(newCartResModel!);
      }
      onCallback(cartResModel);
      notifyListeners();
    });
  }

  Future<void> fetchShippingDetails() async {
    _customerDetailsModel ??= CustomerDetailsModel();
    _customerDetailsModel = await _apiService?.getCustomerDetails();
  }

// NABEGHEHA.COM
  updateCustomerDetails(CustomerDetailsModel customerDetailsModel) async {
    isLoadingShippingDetails = true;
    notifyListeners();
    _customerDetailsModel ??= CustomerDetailsModel();
    _customerDetailsModel =
        await _apiService!.updateCustomerDetails(customerDetailsModel);
    isLoadingShippingDetails = false;
    notifyListeners();
  }

  void createOrder() async {
    _orderModel?.shipping ??= Shipping();
    _orderModel?.billing ??= Billing();

    if (customerDetailsModel?.shipping != null) {
      _orderModel?.shipping = customerDetailsModel?.shipping;
    }
    if (customerDetailsModel?.billing != null) {
      _orderModel?.billing = customerDetailsModel?.billing;
    }

    if (orderModel.lineItems == null) {
      _orderModel?.lineItems = <LineItems>[];
    }

    itemsinCart?.forEach(
      (element) {
        _orderModel!.lineItems?.add(
          LineItems(
            productId: element.productId,
            quantity: element.quantity,
            variationId: element.variationId,
          ),
        );
      },
    );

    await _apiService!.createOrder(orderModel).then((value) {
      _isOrderCreated = true;
      notifyListeners();
    });
  }

  processOrder(OrderModel orderModel) {
    _orderModel = orderModel;
    notifyListeners();
  }

  void initializeData() {
    _apiService = APIService();
    _itemsinCart = <CartItem>[];
  }
}
