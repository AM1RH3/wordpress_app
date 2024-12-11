import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/models/woocommerce/addtocart_request_model.dart';
import 'package:woedpress_app/models/woocommerce/product_model.dart';
import 'package:woedpress_app/providers/loader_provider.dart';
import 'package:woedpress_app/providers/shop_provider.dart';
import 'package:woedpress_app/ui/product_details/product_detail_widget/build_add_tocart.dart';
import 'package:woedpress_app/ui/product_details/product_detail_widget/build_cart_icon.dart';
import 'package:woedpress_app/ui/product_details/product_detail_widget/build_product_description.dart';
// import 'package:woedpress_app/ui/product_details/product_detail_widget/build_product_features.dart';
import 'package:woedpress_app/ui/product_details/product_detail_widget/build_product_image.dart';
import 'package:woedpress_app/ui/product_details/product_detail_widget/build_product_name.dart';
import 'package:woedpress_app/ui/product_details/product_detail_widget/build_product_price.dart';
import 'package:woedpress_app/ui/product_details/product_detail_widget/build_starticon_score.dart';
import 'package:woedpress_app/ui/utils/custom_appbar.dart';

class ProductDetail extends StatefulWidget {
  final Product? product;
  const ProductDetail({
    this.product,
    super.key,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  CartProducts cartProducts = CartProducts();
  late ShopProvider shopProvider =
      Provider.of<ShopProvider>(context, listen: false);
  late LoaderProvider loaderProvider =
      Provider.of<LoaderProvider>(context, listen: true);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const BuildCustomAppBar2(appBarTitle: 'توضیحات محصول'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1200,
          child: Stack(
            children: [
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Flexible(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 55.0, left: 30.0, right: 30.0),
                    height: 880,
                    // width: size.width,
                    // NABEGHEHA.COM
                    decoration: BoxDecoration(
                      color: Constants.primaryColor.withOpacity(0.15),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0),
                      ),
                    ),
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // PRODUCT NAME
                          BuildProductName(productname: widget.product?.name),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BuildProductPrice(
                                      productPrice: '${widget.product?.price}'),
                                  // PRODUCT PRICE
                                ],
                              ),
                              // Star
                              const BuildStarScore(),
                            ],
                          ),
                          // Product Description
                          const SizedBox(height: 15.0),
                          BuildProductDescription(
                            productDescription: widget.product?.description,
                          ),
                          const SizedBox(height: 10.0),
                          TextButton(
                            child: const Text(
                              '...بیشتر',
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 15,
                                fontFamily: 'Lalezar',
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0.0,
                left: 20.0,
                right: 20.0,
                child: Container(
                  width: 600,
                  height: 800,
                  padding: const EdgeInsets.all(20.0),
                  child: Stack(
                    children: [
                      // Product Image
                      BuildProductImage(
                          productImage: widget.product!.images![0].src),
                      // ProductFeatures
                      // const BuildProductFeatures(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: size.width * 0.93,
        height: 50.0,
        child: Row(
          children: [
            const BuildCartIcon(),
            const SizedBox(width: 12.0),
            BuildAddtoCart(
              // NABEGHEHA.COM
              shopProvider: shopProvider,
              loaderProvider: loaderProvider,
              cartProducts: cartProducts,
              productID: widget.product?.id,
            )
          ],
        ),
      ),
    );
  }
}
