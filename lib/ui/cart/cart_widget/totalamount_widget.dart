import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/providers/loader_provider.dart';
import 'package:woedpress_app/providers/shop_provider.dart';
// import 'package:woedpress_app/ui/home/home_page.dart';
import 'package:woedpress_app/ui/utils/extensions.dart';
import 'package:woedpress_app/ui/verify_address/verify_address_page.dart';

class BuildTotalAmount extends StatelessWidget {
  const BuildTotalAmount({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopProvider>(
      builder: (context, cartModel, child) {
        return Flexible(
          flex: 1,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Divider(
                          thickness: 0.5,
                        ),
                        const Text(
                          'جمع کل',
                          style: TextStyle(
                            fontFamily: 'Lalezar',
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 15.0,
                                  child: Image.asset(
                                    'assets/images/PriceUnit-green.png',
                                  ),
                                ),
                                const SizedBox(width: 5.0),
                                Text(
                                  Constants.numberFormat
                                      .format(cartModel.totalAmount)
                                      .farsiNumber,
                                  style: TextStyle(
                                    fontFamily: 'Lalezar',
                                    color: Constants.primaryColor,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Provider.of<LoaderProvider>(context, listen: false)
                            .settLoadingStatus(true);
                        var cartProvider =
                            Provider.of<ShopProvider>(context, listen: false);
                        cartProvider.updateCart((val) {
                          Provider.of<LoaderProvider>(context, listen: false)
                              .settLoadingStatus(false);
                        });
                      },
                      icon: context.watch<LoaderProvider>().isApiCalled
                          ? SizedBox(
                              height: 20.0,
                              width: 20.0,
                              child: LoadingAnimationWidget.threeArchedCircle(
                                color: Constants.primaryColor,
                                size: 30,
                              ),
                            )
                          : const Icon(Icons.sync),
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                    InkResponse(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5),
                        decoration: BoxDecoration(
                          color: Constants.primaryColor,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0.0, 1.1),
                              blurRadius: 5.0,
                              color: Constants.primaryColor.withOpacity(0.3),
                            )
                          ],
                        ),
                        child: InkResponse(
                          onTap: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (BuildContext context) {
                                  return const VerifyAddress();
                                },
                              ),
                            );
                          },
                          child: const Text(
                            'مرحله بعد',
                            style: TextStyle(
                              fontFamily: 'Lalezar',
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
