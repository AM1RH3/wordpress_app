import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:woedpress_app/api/api_service.dart';
import 'package:woedpress_app/db/shared_pr_db.dart';
import 'package:woedpress_app/models/woocommerce/addtocart_request_model.dart';
import 'package:woedpress_app/models/woocommerce/cart_response_model.dart';
import 'package:woedpress_app/models/woocommerce/customer_details_model.dart';
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

  // For Store All-Products
  // List<Product> _product = <Product>[];
  // List<Product> get product => _product;

  // for Store All-Wordpress Posts
  List<WordpressPosts> _worpressPosts = <WordpressPosts>[];
  List<WordpressPosts> get wordpressPosts => _worpressPosts;

  // for Store All-Category-Name's
  List<ProductCategory> _prodictCategory = <ProductCategory>[];
  List<ProductCategory> get productCategory => _prodictCategory;

  // for Store products With Category name
  List<Product> _prodictbyCategory = <Product>[];
  List<Product> get productbyCategory => _prodictbyCategory;

  // items in shopping Cart
  List<CartItem>? _itemsinCart;
  List<CartItem>? get iteminCart => _itemsinCart;

  CustomerDetailsModel? _customerDetailsModel;
  CustomerDetailsModel? get customerDetailsModel => _customerDetailsModel;

  // Sum of Items in ShopInCart
  double? get totalRecords => _itemsinCart!.length.toDouble();

  // Sum of Price in the Shop In Cart
  double? get totalAmount => _itemsinCart != null
      ? _itemsinCart!.map<double?>((e) => e.lineSubtotal).reduce(
            (value, element) => value! + element!,
          )
      : 0;

  //! *************************************************  << getAllWordpressPosts >>   *********************************************************

  Future<void> getAllWordpressPosts() async {
    isLoadingPosts = true;
    notifyListeners();
    final List<WordpressPosts> postResponse = await _apiService!.getPosts();
    _worpressPosts = postResponse;
    isLoadingPosts = false;
    notifyListeners();
  }

  //! *************************************************  << getAllCategoryNames >>   *********************************************************

  Future<void> getAllCategoryNames() async {
    isLoading = true;
    notifyListeners();
    final List<ProductCategory> categoryResponse =
        await _apiService!.getProductCategory();
    _prodictCategory = categoryResponse;
    isLoading = false;
    notifyListeners();
  }

  // Future<void> getAllProducts() async {
  //   isLoading = true;
  //   notifyListeners();
  //   final List<Product> response = await _apiService!.getProducts();
  //   _product = response;
  //   isLoading = false;
  //   notifyListeners();
  // }

  //! *************************************************  << addToCart >>   *********************************************************

  Future<void> getProductsByCategory(String categoryID) async {
    isLoading = true;
    notifyListeners();
    final List<Product> prodictbyCategoryResponse =
        await _apiService!.getProductCategorybyID(categoryID);
    _prodictbyCategory = prodictbyCategoryResponse;
    isLoading = false;
    notifyListeners();
  }

  //! *************************************************  << addToCart >>   *********************************************************
  //?   بر اساس اون اند پوینتی هست که خودمون کاستوم تو سی پنل به وردپرس اضافه کردیم  (php)

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
      (cartresmodel) {
        if (cartresmodel.data != null) {
          List<CartItem>? newCartResModel = cartresmodel.data;
          _itemsinCart = [];
          _itemsinCart!.addAll(newCartResModel!);
        }
        onCallBack(cartresmodel);
        notifyListeners();
      },
    );
  }

  //! *************************************************  << fetchCartItems >>   *********************************************************

  Future<void> fetchCartItems() async {
    isLoading = true;
    notifyListeners();
    bool isLoggedin = await SharedService.isLoggedin();
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
    isLoading = false;
    notifyListeners();
  }

  //! *************************************************  << updateQty >>   *********************************************************

  void updateQty(int productID, int newQty) {
    CartItem? isProductExist =
        _itemsinCart!.firstWhereOrNull((prd) => prd.productId == productID);
    if (isProductExist != null) {
      isProductExist.quantity = newQty;
    }
    notifyListeners();
  }

  //! *************************************************  << removeItem >>   *********************************************************

  void removeItem(int productID) {
    CartItem? isProductExist =
        _itemsinCart!.firstWhereOrNull((prd) => prd.productId == productID);
    if (isProductExist != null) {
      iteminCart!.remove(isProductExist);
    }
    notifyListeners();
  }

  //! *************************************************  << fetchCartItems >>   *********************************************************

  Future<void> updateCart(Function onCallBack) async {
    AddtoCartReqModel reqModel = AddtoCartReqModel();
    reqModel.products = <CartProducts>[];

    if (_itemsinCart == null) initializeData();

    // ignore: avoid_function_literals_in_foreach_calls
    _itemsinCart!.forEach((element) {
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
      onCallBack(cartResModel);
      notifyListeners();
    });
  }

  fetchShippingDetails() async {
    _customerDetailsModel ??= CustomerDetailsModel();
    _customerDetailsModel = await _apiService?.getCustomerDetails();
    notifyListeners();
  }

  updateCustomerDetails(CustomerDetailsModel customerDetailsModel) async {
    isLoadingShippingDetails = true;
    notifyListeners();
    _customerDetailsModel ??= CustomerDetailsModel();
    _customerDetailsModel =
        await _apiService!.updateCustomerDetails(customerDetailsModel);
    isLoadingShippingDetails = false;
    notifyListeners();
  }

  void initializeData() {
    _apiService = APIService();
    _itemsinCart = <CartItem>[];
  }
}
