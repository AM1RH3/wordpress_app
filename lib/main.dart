import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woedpress_app/providers/catalog_provider.dart';
import 'package:woedpress_app/providers/loader_provider.dart';
import 'package:woedpress_app/providers/shop_provider.dart';
import 'package:woedpress_app/ui/catalog/catalog_page.dart';
import 'package:woedpress_app/ui/home/home_page.dart';
import 'package:woedpress_app/ui/product_details/product_detail.dart';
import 'package:woedpress_app/ui/root/root_page.dart';

void main() {
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
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RootPage(),
      ),
    );
  }
}
