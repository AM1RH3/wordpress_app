import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/db/shared_pr_db.dart';
import 'package:woedpress_app/models/woocommerce/addtocart_request_model.dart';
import 'package:woedpress_app/models/woocommerce/cart_response_model.dart';
import 'package:woedpress_app/models/woocommerce/customer_details_model.dart';
import 'package:woedpress_app/models/woocommerce/login_model.dart';
import 'package:woedpress_app/models/woocommerce/order_model.dart';
import 'package:woedpress_app/models/woocommerce/product_category_model.dart';
import 'package:woedpress_app/models/woocommerce/product_model.dart';
import 'package:woedpress_app/models/woocommerce/register_model.dart';
import 'package:woedpress_app/models/wordpress/wordpress_post_model.dart';

class APIService {
  Future<bool> createCustomer(CustomerModel model) async {
    bool returnResponse = false;

    String authToken = base64.encode(
      utf8.encode(
          "${WoocommerceInfo.consumersKey}:${WoocommerceInfo.consumerSecret}"),
    );
    try {
      var response = await Dio()
          .post(WoocommerceInfo.baseURL + WoocommerceInfo.customerURL,
              data: model.toJson(),
              options: Options(headers: {
                HttpHeaders.authorizationHeader: 'Basic $authToken',
                HttpHeaders.contentTypeHeader: 'application/json',
              }));
      if (response.statusCode == 201) {
        returnResponse = true;
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      if (e.response!.statusCode == 404) {
        returnResponse = false;
      } else {
        returnResponse = false;
      }
    }
    return returnResponse;
  }

  Future<LoginResponseModel> loginCustomer(
    String username,
    String password,
  ) async {
    late LoginResponseModel loginModel;
    try {
      var responce = await Dio().post(
        WoocommerceInfo.tokenURL,
        data: {
          'username': username,
          'password': password,
        },
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }),
      );
      if (responce.statusCode == 200) {
        loginModel = LoginResponseModel.fromJson(responce.data);
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      throw 'Error $e';
    }
    return loginModel;
  }

  Future<List<Product>> getProducts() async {
    final String productURL =
        "${WoocommerceInfo.baseURL}${WoocommerceInfo.productURL}?consumer_key=${WoocommerceInfo.consumersKey}&consumer_secret=${WoocommerceInfo.consumerSecret}";
    List<Product> productList = <Product>[];

    try {
      Response response = await Dio().get(
        productURL,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }),
      );
      if (response.statusCode == 200) {
        productList = (response.data as List)
            .map(
              (i) => Product.fromJson(i),
            )
            .toList();
      }
    } on DioException catch (e) {
      throw 'Error $e';
    }
    return productList;
  }

  Future<List<ProductCategory>> getProductCategory() async {
    final String productCategoryURL =
        "${WoocommerceInfo.baseURL}${WoocommerceInfo.productCategoryURL}?consumer_key=${WoocommerceInfo.consumersKey}&consumer_secret=${WoocommerceInfo.consumerSecret}";
    List<ProductCategory> productCategoryList = <ProductCategory>[];

    try {
      Response response = await Dio().get(
        productCategoryURL,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }),
      );
      if (response.statusCode == 200) {
        productCategoryList = (response.data as List)
            .map(
              (i) => ProductCategory.fromJson(i),
            )
            .toList();
      }
    } on DioException catch (e) {
      throw 'Error $e';
    }
    return productCategoryList;
  }

  Future<List<Product>> getProductCategorybyID(String catID) async {
    final String productCategoryURL =
        "${WoocommerceInfo.baseURL}${WoocommerceInfo.productURL}?category=$catID&consumer_key=${WoocommerceInfo.consumersKey}&consumer_secret=${WoocommerceInfo.consumerSecret}";
    List<Product> productCategoryList = <Product>[];

    try {
      Response response = await Dio().get(
        productCategoryURL,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }),
      );
      if (response.statusCode == 200) {
        productCategoryList = (response.data as List)
            .map(
              (i) => Product.fromJson(i),
            )
            .toList();
      }
    } on DioException catch (e) {
      throw 'Error $e';
    }
    return productCategoryList;
  }

  Future<List<WordpressPosts>> getPosts() async {
    final String postURL = WoocommerceInfo.baseURLPosts;
    List<WordpressPosts> postList = <WordpressPosts>[];

    try {
      Response response = await Dio().get(
        postURL,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }),
      );
      if (response.statusCode == 200) {
        postList = (response.data as List)
            .map(
              (i) => WordpressPosts.fromJson(i),
            )
            .toList();
      }
    } on DioException catch (e) {
      throw 'Error $e';
    }
    return postList;
  }

  Future<AddtoCartResModel> addtoCart(AddtoCartReqModel model) async {
    LoginResponseModel? loginResponseModel = await SharedService.loginDetails();
    if (loginResponseModel?.data != null) {
      model.userId = loginResponseModel!.data!.id;
    }
    String url = WoocommerceInfo.baseURL + WoocommerceInfo.addtocartURL;

    late AddtoCartResModel responseModel;

    try {
      Response response = await Dio().post(url,
          data: model.toJson(),
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          }));
      if (response.statusCode == 200) {
        responseModel = AddtoCartResModel.fromJson(response.data);
      }

      // ignore: deprecated_member_use
    } on DioError catch (e) {
      if (e.response!.statusCode == 404) {
        throw 'Error $e';
      }
    }
    return responseModel;
  }

  Future<List<Product>> getCatalog({
    int? pageNumber,
    int? pageSize,
    String? searchKeyword,
    String? tagName,
    String? sortBy,
    String sortOrder = 'desc',
  }) async {
    List<Product> productList = <Product>[];

    try {
      String parameter = '';
      if (searchKeyword != null) {
        parameter += '&search=$searchKeyword';
      }
      if (pageSize != null) {
        parameter += '&per_page=$pageSize';
      }
      if (pageNumber != null) {
        parameter += '&page=$pageNumber';
      }
      if (tagName != null) {
        parameter += '&tag=$tagName';
      }
      if (sortBy != null) {
        parameter += '&orderby=$sortBy';
      }
      if (sortOrder != 'desc') {
        parameter += '&order=asc';
      } else {
        parameter += '&order=desc';
      }

      final String productURL =
          "${WoocommerceInfo.baseURL}${WoocommerceInfo.productURL}?consumer_key=${WoocommerceInfo.consumersKey}&consumer_secret=${WoocommerceInfo.consumerSecret}${parameter.toString()}";
      Response response = await Dio().get(
        productURL,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        productList = (response.data as List)
            .map(
              (i) => Product.fromJson(i),
            )
            .toList();
      }
    } on DioException catch (e) {
      throw 'Error $e';
    }
    return productList;
  }

  Future<AddtoCartResModel> getCartItems() async {
    late AddtoCartResModel responseModel;

    try {
      LoginResponseModel? loginResponseModel =
          await SharedService.loginDetails();
      if (loginResponseModel?.data != null) {
        int? userID = loginResponseModel!.data!.id;
        final String url =
            "${WoocommerceInfo.baseURL}${WoocommerceInfo.cartURL}?user_id=$userID&?consumer_key=${WoocommerceInfo.consumersKey}&consumer_secret=${WoocommerceInfo.consumerSecret}";
        Response response = await Dio().get(
          url,
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
          ),
        );
        if (response.statusCode == 200) {
          responseModel = AddtoCartResModel.fromJson(response.data);
        }
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      throw 'Error $e';
    }
    return responseModel;
  }

  Future<CustomerDetailsModel?> getCustomerDetails() async {
    CustomerDetailsModel? responseModel;

    try {
      LoginResponseModel? loginResponseModel =
          await SharedService.loginDetails();
      if (loginResponseModel?.data != null) {
        int? userID = loginResponseModel!.data!.id;

        String url =
            "${WoocommerceInfo.baseURL}${WoocommerceInfo.customerURL}/$userID?consumer_key=${WoocommerceInfo.consumersKey}&consumer_secret=${WoocommerceInfo.consumerSecret}";
        Response response = await Dio().get(
          url,
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
          ),
        );
        if (response.statusCode == 200) {
          responseModel = CustomerDetailsModel.fromJson(response.data);
        }
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      throw 'Error $e';
    }
    return responseModel;
  }

  Future<CustomerDetailsModel> updateCustomerDetails(
    CustomerDetailsModel model,
  ) async {
    CustomerDetailsModel? responseModel;

    try {
      LoginResponseModel? loginResponseModel =
          await SharedService.loginDetails();
      if (loginResponseModel?.data != null) {
        int? userID = loginResponseModel!.data!.id;

        String url =
            "${WoocommerceInfo.baseURL}${WoocommerceInfo.customerURL}/$userID?consumer_key=${WoocommerceInfo.consumersKey}&consumer_secret=${WoocommerceInfo.consumerSecret}";
        Response response = await Dio().post(
          url,
          data: model.toJson(),
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
          ),
        );
        if (response.statusCode == 200) {
          responseModel = CustomerDetailsModel.fromJson(response.data);
        }
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      throw 'Error $e';
    }
    return responseModel!;
  }

  // order model on zarinpall movies
  Future<List<OrderModel>> getAllOrders() async {
    List<OrderModel> allOrders = <OrderModel>[];

    try {
      // LoginResponseModel? loginResponseModel =
      //     await SecureSorageDB().loginDetails();
      // if (loginResponseModel?.data != null) {
      //   int? userID = loginResponseModel?.data!.id;
      LoginResponseModel? loginResponseModel =
          await SharedService.loginDetails();
      if (loginResponseModel?.data != null) {
        int? userID = loginResponseModel?.data!.id;

        final String url =
            "${WoocommerceInfo.baseURL}${WoocommerceInfo.orderURL}?consumer_key=${WoocommerceInfo.consumersKey}&consumer_secret=${WoocommerceInfo.consumerSecret}&customer=$userID";
        Response response = await Dio().get(
          url,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          }),
        );

        if (response.statusCode == 200) {
          allOrders = (response.data as List)
              .map(
                (i) => OrderModel.fromJson(i),
              )
              .toList();
        }
      }
    } on DioException catch (e) {
      throw 'Error $e';
    }
    return allOrders;
  }
}
