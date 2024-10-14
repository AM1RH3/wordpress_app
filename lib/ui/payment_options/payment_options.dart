import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:provider/provider.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/providers/shop_provider.dart';
import 'package:woedpress_app/ui/payment_options/payment_utils.dart';
import 'package:woedpress_app/ui/utils/extensions.dart';

class PaymentOptions extends StatefulWidget {
  const PaymentOptions({super.key});

  @override
  State<PaymentOptions> createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  NumberFormat numberFormat = NumberFormat.decimalPattern('fa');

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopProvider>(
      builder: (context, cartModel, child) {
        if (cartModel.customerDetailsModel!.id != null) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 90.0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    //! X Button
                    child: Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: Constants.primaryColor.withOpacity(0.15),
                      ),
                      child: Icon(
                        Icons.close,
                        color: Constants.primaryColor,
                      ),
                    ),
                  ),
                  //! Register Text
                  Text(
                    'روش پرداخت',
                    style: TextStyle(
                      color: Constants.blackColor,
                      fontFamily: 'Lalezar',
                      fontSize: 24.0,
                    ),
                  )
                ],
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0.0,
            ),
            bottomNavigationBar: BottomAppBar(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                height: 80.0,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Constants.primaryColor.withOpacity(0.3),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 20.0,
                          child:
                              Image.asset('assets/images/PriceUnit-green.png'),
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                          numberFormat
                              .format(cartModel.totalAmount)
                              .farsiNumber,
                          style: TextStyle(
                            fontFamily: 'Lalezar',
                            color: Constants.primaryColor,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      textDirection: TextDirection.rtl,
                      ': مبلغ نهایی ',
                      style: TextStyle(
                        fontFamily: 'Lalezar',
                        fontSize: 25.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: _formUI(),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

Widget _formUI() {
  return SingleChildScrollView(
    child: Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            //! ONLINE PAYMENTS

            const BuildPamentOptions(
              icon: Icons.payment,
              paymentTitle: 'پرداخت آنلاین',
              paymentDescription: 'از روش های زیر یکی را انتخاب کنید',
            ),
            // Payment Methods
            const SizedBox(height: 20.0),

            // ZarinPal
            BuildClickPaymentMethod(
              paymentTitle: 'زرین پال',
              paymentDescription: 'پرداخت آنلاین با درگاه زرین پال',
              assetImageUrl: 'assets/images/zarin.png',
              onPressed: () {},
            ),
            const SizedBox(height: 15.0),
            // NextPay
            BuildClickPaymentMethod(
              paymentTitle: 'زرین پال',
              paymentDescription: 'پرداخت آنلاین با درگاه زرین پال',
              assetImageUrl: 'assets/images/zarin.png',
              onPressed: () {},
            ),
            const SizedBox(height: 50.0),

            //! OFFLINE PAYMENTS

            const BuildPamentOptions(
              icon: Icons.location_on,
              paymentTitle: 'سایر روش های پرداخت',
              paymentDescription: 'از روش های زیر یکی را انتخاب کنید',
            ),
            // Payment Methods
            const SizedBox(height: 20.0),

            // ZarinPal
            BuildClickPaymentMethod(
              paymentTitle: 'پرداخت در محل',
              paymentDescription: 'پرداخت درب منزل با دستگاه کارتخوان',
              assetImageUrl: 'assets/images/cod.png',
              onPressed: () {},
            ),
          ],
        ),
      ),
    ),
  );
}
