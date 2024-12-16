import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/providers/loader_provider.dart';
import 'package:woedpress_app/providers/shop_provider.dart';
import 'package:woedpress_app/ui/root/root_page.dart';
import 'package:woedpress_app/ui/utils/extensions.dart';

class PaymentResult extends StatelessWidget {
  final String image;

  final String paymentResultText;
  final String paymentRefID;
  final ShopProvider shopProvider;
  final LoaderProvider loaderProvider;
  const PaymentResult({
    super.key,
    required this.shopProvider,
    required this.loaderProvider,
    required this.image,
    required this.paymentResultText,
    required this.paymentRefID,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          Image.asset(
            image,
            width: 300,
            height: 300,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: Text(
              paymentResultText,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Lalezar',
                fontSize: 30.0,
              ),
            ),
          ),
          const SizedBox(height: 25.0),
          Text(
            "کد پیگیری تراکنش : $paymentRefID".farsiNumber,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontFamily: 'Lalezar',
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.primaryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 12.0,
                  ),
                ),
                onPressed: () {
                  shopProvider.resetCart(
                    (val) {
                      loaderProvider.settLoadingStatus(true);
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacement(
                        CupertinoPageRoute(
                          builder: (context) {
                            return const RootPage();
                          },
                        ),
                      );
                      loaderProvider.settLoadingStatus(false);
                    },
                  );
                },
                child: const Text(
                  'بازگشت به صفحه اصلی',
                  style: TextStyle(
                    fontFamily: 'Lalezar',
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
