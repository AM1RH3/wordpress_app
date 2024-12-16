import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/providers/shop_provider.dart';
import 'package:woedpress_app/ui/cart/cart_page.dart';
import 'package:woedpress_app/ui/utils/extensions.dart';

class BuildCartIcon extends StatelessWidget {
  const BuildCartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
        color: Constants.primaryColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0.0, 1.1),
            blurRadius: 5.0,
            color: Constants.primaryColor.withOpacity(0.3),
          )
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) {
                return const CartPage();
              },
            ),
          );
        },
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
                          .itemsinCart ==
                      null
                  ? Text(
                      '0'.farsiNumber,
                      style: const TextStyle(
                        fontSize: 25.0,
                        fontFamily: 'Lalezar',
                      ),
                    )
                  : Text(
                      Provider.of<ShopProvider>(context, listen: true)
                          .itemsinCart!
                          .length
                          .toString()
                          .farsiNumber,
                      style: const TextStyle(
                        fontSize: 25.0,
                        fontFamily: 'Lalezar',
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
