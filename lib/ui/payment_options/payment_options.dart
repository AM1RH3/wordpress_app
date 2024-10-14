import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:provider/provider.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/providers/shop_provider.dart';

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
                  children: [
                    SizedBox(
                      height: 20.0,
                      child: Image.asset('assets/images/PriceUnit-green.png'),
                    ),
                    const SizedBox(width: 5.0),
                    Text(),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
