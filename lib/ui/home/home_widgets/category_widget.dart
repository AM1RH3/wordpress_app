import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/models/woocommerce/product_model.dart';
import 'package:woedpress_app/providers/shop_provider.dart';

class BuildCategory extends StatelessWidget {
  final Size size;
// NABEGHEHA.COM
  BuildCategory({
    super.key,
    required this.size,
  });

  final List<Categories> productsCategoryNames = <Categories>[
    Categories(orderId: 1, id: 16, name: '|دسته بندی نشده|'),
    Categories(orderId: 1, id: 20, name: '| برنامه‌نویسی |'),
    Categories(orderId: 2, id: 22, name: '| امنیت |'),
    Categories(orderId: 3, id: 24, name: '| شبکه |'),
    Categories(orderId: 4, id: 21, name: '| لینوکس |'),
    Categories(orderId: 5, id: 19, name: '| آموزشی |'),
  ];

  @override
  Widget build(BuildContext context) {
    productsCategoryNames
        .sort((a, b) => a.orderId!.compareTo(b.orderId as num));
    return Consumer<ShopProvider>(
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          height: 70.0,
          width: size.width,
          child: ListView.builder(
            reverse: true,
            scrollDirection: Axis.horizontal,
            itemCount: productsCategoryNames.length,
            itemBuilder: (BuildContext context, int index) {
              final catID = productsCategoryNames[index].id;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    value.selectedIndex = index;
                    value.getProductsByCategory(catID.toString());
                  },
                  child: Text(
                    // NABEGHEHA.COM
                    productsCategoryNames[index].name.toString(),
                    style: TextStyle(
                      fontFamily: 'iranSans',
                      fontSize: 16.0,
                      fontWeight: value.selectedIndex == index
                          ? FontWeight.bold
                          : FontWeight.w300,
                      color: value.selectedIndex == index
                          ? Constants.primaryColor
                          : Constants.blackColor,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
