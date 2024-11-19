import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woedpress_app/providers/catalog_provider.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/models/woocommerce/product_model.dart';
import 'package:woedpress_app/ui/product_details/product_detail.dart';

class BuildCatalogProducts extends StatelessWidget {
  final ScrollController scrollController;
  const BuildCatalogProducts({
    super.key,
    required this.scrollController,
  });
  // NABEGHEHA.COM

  @override
  Widget build(BuildContext context) {
    CatalogProvider productList =
        Provider.of<CatalogProvider>(context, listen: false);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Flexible(
        child: SingleChildScrollView(
          controller: scrollController,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: GridView.count(
            scrollDirection: Axis.vertical,
            crossAxisCount: productList.allProduct.length < 2 ? 1 : 2,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: productList.allProduct.map(
              (Product product) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (BuildContext context) {
                          return ProductDetail(product: product);
                        },
                      ),
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0XFFFFFFFF),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Color(0xfff8f8f8),
                            blurRadius: 15.0,
                            spreadRadius: 10.0),
                      ],
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 30.0,
                                    backgroundColor:
                                        const Color(0xffe65829).withAlpha(40),
                                  ),
                                  Image.network(
                                    product.images![0].src.toString(),
                                    height: 80.0,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                product.name.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: 'Lalezar',
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // NABEGHEHA.COM
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${Constants.numberFormat.format(int.parse(product.price ?? '000'))} تومان',
                                    textDirection: TextDirection.rtl,
                                    style: const TextStyle(
                                      fontFamily: 'Lalezar',
                                      fontSize: 13.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
