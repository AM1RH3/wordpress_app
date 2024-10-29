import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/db/shared_pr_db.dart';
import 'package:woedpress_app/providers/loader_provider.dart';
import 'package:woedpress_app/providers/shop_provider.dart';
import 'package:woedpress_app/ui/login/login_page.dart';
import 'package:woedpress_app/ui/utils/custom_add_quantity.dart';
import 'package:woedpress_app/ui/utils/extensions.dart';
import 'package:woedpress_app/ui/verify_address/verify_address_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      ShopProvider cartItemsList =
          Provider.of<ShopProvider>(context, listen: false);
      cartItemsList.initializeData();
      cartItemsList.fetchCartItems();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat = NumberFormat.decimalPattern('fa');
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: SharedService.isLoggedin(),
      builder: (BuildContext context, AsyncSnapshot<bool> loginModel) {
        if (loginModel.hasData && loginModel.data!) {
          return Consumer<ShopProvider>(
            builder: (context, cartModel, child) {
              if (cartModel.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (cartModel.itemsinCart!.isNotEmpty) {
                return Scaffold(
                  body: Column(
                    children: [
                      Flexible(
                        flex: 8,
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 15.0, left: 15.0, right: 15.0),
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: cartModel.itemsinCart!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  color:
                                      Constants.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                height: 90.0,
                                width: size.width,
                                margin: const EdgeInsets.only(
                                    bottom: 10.0, top: 10.0),
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 20.0,
                                          child: Image.asset(
                                            'assets/images/PriceUnit-green.png',
                                          ),
                                        ),
                                        const SizedBox(width: 5.0),
                                        Text(
                                          numberFormat.format(
                                            int.parse(
                                              cartModel.itemsinCart![index]
                                                  .productRegularPrice
                                                  .toString(),
                                            ),
                                          ),
                                          style: TextStyle(
                                            fontFamily: 'Lalezar',
                                            color: Constants.primaryColor,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              cartModel.itemsinCart![index]
                                                  .productName
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 13.0,
                                                fontFamily: 'Lalezar',
                                              ),
                                            ),
                                            // const SizedBox(width: 19.0),
                                          ],
                                        ),
                                        CustomQuantity(
                                          minNumber: 0,
                                          maxNumber: 20,
                                          iconSize: 15.0,
                                          value: cartModel
                                              .itemsinCart![index].quantity!
                                              .toInt(),
                                          onChanged: (value) {
                                            if (cartModel.itemsinCart![index]
                                                    .quantity! >
                                                0) {
                                              Provider.of<ShopProvider>(context,
                                                      listen: false)
                                                  .updateQty(
                                                cartModel.itemsinCart![index]
                                                    .productId!,
                                                value,
                                              );
                                            } else {
                                              Provider.of<ShopProvider>(context,
                                                      listen: false)
                                                  .removeItem(
                                                cartModel.itemsinCart![index]
                                                    .productId!,
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 5.0, right: 5.0),
                                          child: Container(
                                            width: 60.0,
                                            height: 60.0,
                                            decoration: BoxDecoration(
                                              color: Constants.primaryColor
                                                  .withOpacity(0.8),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                        // NABEGHEHA.COM
                                        Positioned(
                                          bottom: 3,
                                          left: 7,
                                          right: 12,
                                          top: 0,
                                          child: SizedBox(
                                            height: 60.0,
                                            child: Image.network(
                                              cartModel
                                                  .itemsinCart![index].thumbnail
                                                  .toString(),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Divider(thickness: 0.5),
                                      const Text(
                                        'جمع کل',
                                        style: TextStyle(
                                          fontFamily: 'Lalezar',
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                numberFormat
                                                    .format(
                                                        cartModel.totalAmount)
                                                    .farsiNumber,
                                                style: TextStyle(
                                                  fontFamily: 'Lalezar',
                                                  color: Constants.primaryColor,
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ],
                                          )
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
                                        Provider.of<LoaderProvider>(context,
                                                listen: false)
                                            .settLoadingStatus(false);
                                        var cartProvider =
                                            Provider.of<ShopProvider>(context,
                                                listen: false);
                                        cartProvider.updateCart((val) {
                                          Provider.of<LoaderProvider>(context,
                                                  listen: false)
                                              .settLoadingStatus(true);
                                        });
                                      },
                                      icon: const Icon(Icons.sync)),
                                  InkResponse(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 5.0),
                                      decoration: BoxDecoration(
                                        color: Constants.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(0.0, 1.1),
                                            blurRadius: 5.0,
                                            color: Constants.primaryColor
                                                .withOpacity(0.3),
                                          ),
                                        ],
                                      ),
                                      child: InkResponse(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              child: const VerifyAddress(),
                                              type: PageTransitionType.fade,
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
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                        child: Image.asset('assets/images/add-cart.png'),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'سبد خرید تار عنکبوت بسته است',
                        style: TextStyle(
                          fontFamily: 'Lalezar',
                          fontWeight: FontWeight.w300,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/need_sign.png',
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'برای مشاهده باید وارد حساب شوید',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 30,
                      fontFamily: 'YekanBakh'),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.primaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50.0,
                        vertical: 12.0,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                          child: const LoginPage(),
                          type: PageTransitionType.fade,
                        ),
                        ModalRoute.withName('LoginPage'),
                      );
                    },
                    child: const Text(
                      'ورود به برنامه',
                      style: TextStyle(fontFamily: 'iranSans', fontSize: 15.0),
                    ))
              ],
            ),
          );
        }
      },
    );
  }
}
