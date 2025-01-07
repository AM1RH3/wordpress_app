import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:woedpress_app/providers/catalog_provider.dart';
import 'package:woedpress_app/providers/loader_provider.dart';
import 'package:woedpress_app/providers/order_provider.dart';
import 'package:woedpress_app/providers/shop_provider.dart';
import 'package:woedpress_app/ui/catalog/catalog_page.dart';
import 'package:woedpress_app/ui/home/home_page.dart';
import 'package:woedpress_app/ui/product_details/product_detail.dart';
import 'package:woedpress_app/ui/profile/orders_page.dart';

import 'package:woedpress_app/ui/unauthorized/login_check.dart';

// #AmirH3

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ShopProvider(),
          child: const HomePage(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoaderProvider(),
          child: const ProductDetail(),
        ),
        ChangeNotifierProvider(
          create: (context) => CatalogProvider(),
          child: const CatalogPage(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
          child: const OrdersPage(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginOrNot(),
      ),
    );
  }
}
