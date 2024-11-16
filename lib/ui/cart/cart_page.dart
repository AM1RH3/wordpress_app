import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/providers/shop_provider.dart';
import 'package:woedpress_app/ui/cart/cart_widget/cartitems_widget.dart';
import 'package:woedpress_app/ui/cart/cart_widget/totalamount_widget.dart';
import 'package:woedpress_app/ui/cart/cart_widget/widget_empty_cart.dart';
import 'package:woedpress_app/ui/utils/custom_appbar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late ShopProvider cartItemsList =
      Provider.of<ShopProvider>(context, listen: false);
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      ShopProvider cartItemsList =
          Provider.of<ShopProvider>(context, listen: false);
      cartItemsList.initializeData();
      cartItemsList.fetchCartItems();
    });
    // NABEGHEHA.COM
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const BuildCustomAppBar(appBarTitle: 'سبد خرید'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: cartItemsList.fetchCartItems(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return Consumer<ShopProvider>(
            builder: (context, cartModel, child) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Constants.primaryColor,
                    size: 50,
                  ),
                );
                // NABEGHEHA.COM
              } else if (cartModel.itemsinCart!.isEmpty) {
                return const BuildEmptyCart();
              } else {
                return Scaffold(
                  body: Column(
                    children: [
                      BuildCartItems(size: size),
                      const Divider(thickness: 1),
                      const BuildTotalAmount(),
                    ],
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
