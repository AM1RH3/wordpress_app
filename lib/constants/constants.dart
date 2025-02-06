import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WoocommerceInfo {
  // CONSUMERKEY & CONSUM ERSECRET
  static String consumersKey = 'Ck_on_wordpress';
  static String consumerSecret = 'Cs_on_wordpress';

  // BASE URL WOOCOMMERCE
  static String baseURL = 'url.../wp-json/wc/v3/';

  //Base URL of Wordpress
  static String baseURLPosts =
      'url.../wp-json/wp/v2/posts?_embed';

  // URL For AUTH with JWT
  static String tokenURL =
      'url.../wp-json/jwt-auth/v1/token';

  // API ENDPOINTS
  static String customerURL = 'customers';
  static String productURL = 'products';
  static String addtocartURL = 'addtocart';
  static String cartURL = 'cart';
  static String productCategoryURL = 'products/categories';
  static String orderURL = 'orders';
}

class Constants {
  static final NumberFormat numberFormat = NumberFormat.decimalPattern('fa');
  static Color primaryColor = const Color.fromARGB(255, 18, 143, 200);
  static Color blackColor = Colors.black54;

  // static String titleOne = "گیاهان را بهتر از قبل درک کن";
  // static String descriptionOne =
  //     "درمورد نگه داری گل و گیاهان میتوانی اطلاعات کسب کنی";
  // static String titleTwo = "با گیاهان جدید آشنا شو";
  // static String descriptionTwo =
  //     "رز مشکی یا گل رز دوست داری ؟ اینجا میتونی پیداش کنی";
  // static String titleThree = "با یک گل بهار آغاز نمی شود، گل بکار";
  // static String descriptionThree =
  //     "هر گلی نیاز داشته باشید در این اپلیکیشن پیدا می کنید";
}

class ZarinpalInfo {
  static String zarinpalMerchId = 'af7551b1-3d35-49c6-a11f-6caaa9ee63b3';
  static String zarinpalCallBackURL = 'http://am1rh3.ir/?i=1';
  static String zarinpalRequestURL =
      'https://sandbox.zarinpal.com/pg/v4/payment/request.json';
  static const String zarinpalVerifyURL =
      'https://api.zarinpal.com/pg/v4/payment/verify.json';
  //todo maybe ↑SandBox
}
