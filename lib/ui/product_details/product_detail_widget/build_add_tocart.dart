import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/models/woocommerce/addtocart_request_model.dart';
import 'package:woedpress_app/providers/loader_provider.dart';
import 'package:woedpress_app/providers/shop_provider.dart';

class BuildAddtoCart extends StatelessWidget {
  final ShopProvider shopProvider;
  final LoaderProvider loaderProvider;
  final CartProducts cartProducts;
  final int? productID;

  const BuildAddtoCart({
    super.key,
    required this.shopProvider,
    required this.loaderProvider,
    required this.cartProducts,
    required this.productID,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Constants.primaryColor,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0.0, 1.1),
              blurRadius: 5.0,
              color: Constants.primaryColor.withOpacity(0.3),
            )
          ],
        ),
        child: Center(
          child: InkResponse(
            onTap: () {
              loaderProvider.settLoadingStatus(true);
              cartProducts.productId = productID;
              cartProducts.quantity = 1;
              shopProvider.addToCart(cartProducts, (val) {
                loaderProvider.settLoadingStatus(false);
              });
            },
            child: loaderProvider.isApiCalled
                ? Center(
                    child: LoadingAnimationWidget.progressiveDots(
                      color: Colors.white,
                      size: 50,
                    ),
                  )
                : const Text(
                    'افزودن به سبد خرید',
                    style: TextStyle(
                      fontFamily: 'Lalezar',
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
