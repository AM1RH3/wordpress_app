import 'package:flutter/material.dart';

class WoocommerceInfo {
  // CONSUMERKEY & CONSUM ERSECRET
  static String consumersKey = 'ck_298f4c0e905e2afb75e1332ddf4361eb78138a3d';
  static String consumerSecret = 'cs_68522ee14f072a16b1d947282f0adf398d7999d2';

  // BASE URL WOOCOMMERCE
  static String baseURL = 'https://webdev-demo.ir/amir/wp-json/wc/v3/';

  //Base URL of Wordpress
  static String baseURLPosts =
      'https://webdev-demo.ir/amir/wp-json/wp/v2/posts?_embed';

  // URL For AUTH with JWT
  static String tokenURL =
      'https://webdev-demo.ir/amir/wp-json/jwt-auth/v1/token';

  // API ENDPOINTS
  static String customerURL = 'customers';
  static String productURL = 'products';
  static String addtocartURL = 'addtocart';
  static String cartURL = 'cart';
  static String productCategoryURL = 'products/categories';
}

class Constants {
  static Color primaryColor = const Color(0xFF296E48);
  static Color blackColor = Colors.black54;

  static String titleOne = "گیاهان را بهتر از قبل درک کن";
  static String descriptionOne =
      "درمورد نگه داری گل و گیاهان میتوانی اطلاعات کسب کنی";
  static String titleTwo = "با گیاهان جدید آشنا شو";
  static String descriptionTwo =
      "رز مشکی یا گل رز دوست داری ؟ اینجا میتونی پیداش کنی";
  static String titleThree = "با یک گل بهار آغاز نمی شود، گل بکار";
  static String descriptionThree =
      "هر گلی نیاز داشته باشید در این اپلیکیشن پیدا می کنید";
}
