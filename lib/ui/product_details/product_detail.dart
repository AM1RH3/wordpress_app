import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:provider/provider.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/models/woocommerce/addtocart_request_model.dart';
import 'package:woedpress_app/models/woocommerce/product_model.dart';
import 'package:woedpress_app/providers/loader_provider.dart';
import 'package:woedpress_app/providers/shop_provider.dart';
// import 'package:woedpress_app/ui/utils/custom_add_quantity.dart';
import 'package:woedpress_app/ui/utils/custom_appbar.dart';
import 'package:woedpress_app/ui/utils/extensions.dart';

class ProductDetail extends StatefulWidget {
  final Product? product;

  const ProductDetail({
    super.key,
    this.product,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  NumberFormat numberFormat = NumberFormat.decimalPattern('fa');

  int quantity = 0;
  CartProducts cartProducts = CartProducts();

  bool toggleIsSelected(bool isSelected) {
    return !isSelected;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<LoaderProvider>(
      builder: (context, loader, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const BuildCustomAppBar2(appBarTitle: 'توضیحات محصول'),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0.0,
          ),
          body: Stack(
            children: [
              //! ******************************************** < AppBar > ****************************************************
              // const BuildCustomAppBar2(appBarTitle: 'توضیحات محصول'),
              Positioned(
                //!!!! ??????????
                top: 10.0,
                left: 20.0,
                right: 20.0,
                child: Container(
                  width: size.width * 0.8,
                  height: size.height * 0.8,
                  padding: const EdgeInsets.all(20.0),
                  child: Stack(
                    children: [
                      //! ********************************* < Product Image > *****************************************************
                      Positioned(
                        top: 10.0,
                        left: 0.0,
                        child: SizedBox(
                          height: 230.0,
                          child: Image.network(
                            widget.product!.images != null &&
                                    widget.product!.images!.isNotEmpty
                                ? widget.product!.images![0].src.toString()
                                : 'https://via.placeholder.com/150',
                          ),
                        ),
                      ),
                      //! ******************************** < Toterial Feature > **************************************************
                      const Positioned(
                        top: 100.0,
                        right: 0,
                        child: SizedBox(
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              PlantFeature(
                                title: 'مدرس',
                                plantFeature: 'امیرحسین معلمی',
                              ),
                              PlantFeature(
                                title: 'پیشنیاز',
                                plantFeature: 'ندارد',
                              ),
                              PlantFeature(
                                title: 'سطح',
                                plantFeature: 'پیشرفته',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding:
                      const EdgeInsets.only(top: 30.0, right: 30.0, left: 30.0),
                  height: size.height * 0.5,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Constants.primaryColor.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                size: 30.0,
                                color: Constants.primaryColor,
                              ),
                              Text(
                                '4.9'.farsiNumber,
                                style: TextStyle(
                                    color: Constants.primaryColor,
                                    fontFamily: 'Lalezar',
                                    fontSize: 23.0),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                widget.product!.name.toString(),
                                style: TextStyle(
                                  color: Constants.primaryColor,
                                  fontFamily: 'Lalezar',
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 20.0,
                                    child: Image.asset(
                                        'assets/images/PriceUnit-green.png'),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    numberFormat
                                        .format(int.parse(
                                            widget.product!.price.toString()))
                                        .farsiNumber,
                                    style: TextStyle(
                                      color: Constants.blackColor,
                                      fontFamily: 'Lalezar',
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      Text(
                        widget.product!.shortDescription
                            .toString()
                            .removeAllHtmlTags,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Constants.blackColor.withOpacity(0.7),
                          height: 1.6,
                          fontFamily: 'iranSans',
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: SizedBox(
            width: size.width * 0.9,
            height: 50.0,
            child: Row(
              children: [
                Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    color: Constants.primaryColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(50.0),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0.0, 1.1),
                        blurRadius: 5.0,
                        color: Constants.primaryColor.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      Positioned(
                        right: 9.0,
                        top: -4.0,
                        child: Provider.of<ShopProvider>(context, listen: true)
                                    .iteminCart ==
                                null
                            ? Text(
                                '0'.farsiNumber,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Lalezar',
                                ),
                              )
                            : Text(
                                Provider.of<ShopProvider>(context, listen: true)
                                    .iteminCart!
                                    .length
                                    .toString()
                                    .farsiNumber,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Lalezar',
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                // CustomQuantity(
                //   minNumber: 0,
                //   maxNumber: 10,
                //   iconSize: 22.0,
                //   value: quantity,
                //   onChanged: (value) {
                //     cartProducts.quantity = value;
                //   },
                // ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Constants.primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0.0, 1.1),
                          blurRadius: 5.0,
                          color: Constants.primaryColor.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: InkResponse(
                        onTap: () {
                          Provider.of<LoaderProvider>(context, listen: false)
                              .settLoadingStatus(true);
                          ShopProvider cartProvider =
                              Provider.of<ShopProvider>(context, listen: false);
                          cartProducts.productId = widget.product!.id;
                          cartProducts.quantity = 1;
                          cartProvider.addToCart(cartProducts, (val) {
                            Provider.of<LoaderProvider>(context, listen: false)
                                .settLoadingStatus(false);
                          });
                        },
                        child: const Text(
                          'افزودن به سبد خرید ',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Lalezar',
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PlantFeature extends StatelessWidget {
  final String title;
  final String plantFeature;
  const PlantFeature({
    super.key,
    required this.title,
    required this.plantFeature,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Constants.blackColor,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lalezar',
          ),
        ),
        Text(
          plantFeature,
          style: TextStyle(
            color: Constants.primaryColor,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lalezar',
          ),
        ),
      ],
    );
  }
}
