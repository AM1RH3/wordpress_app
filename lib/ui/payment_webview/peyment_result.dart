import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:woedpress_app/providers/loader_provider.dart';
import 'package:woedpress_app/providers/shop_provider.dart';
import 'package:woedpress_app/ui/payment_webview/result_widget.dart';
import 'package:woedpress_app/ui/utils/custom_appbar.dart';

class ZarinpalSuccess extends StatefulWidget {
  // NABEGHEHA.COM
  final int? refID;
  const ZarinpalSuccess({
    super.key,
    this.refID,
  });

  @override
  State<ZarinpalSuccess> createState() => _ZarinpalSuccessState();
}

class _ZarinpalSuccessState extends State<ZarinpalSuccess> {
  @override
  void initState() {
    Provider.of<ShopProvider>(context, listen: false).createOrder();
    super.initState();
  }

  late LoaderProvider loaderProvider =
      Provider.of<LoaderProvider>(context, listen: false);
  late ShopProvider shopProvider =
      Provider.of<ShopProvider>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const BuildCustomAppBar(appBarTitle: 'نتیجه پرداخت'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: widget.refID != null
          ? PaymentResult(
              image: 'assets/images/successful_payment.png',
              paymentResultText: 'تراکنش موفقیت آمیز بود',
              paymentRefID: widget.refID.toString(),
              shopProvider: shopProvider,
              loaderProvider: loaderProvider,
            )
          : PaymentResult(
              // NABEGHEHA.COM
              image: 'assets/images/unsuccessful_payment.png',
              paymentResultText: 'تراکنش موفقیت آمیز نبود',
              paymentRefID: 'با پشتیبانی تماس بگیرید',
              shopProvider: shopProvider,
              loaderProvider: loaderProvider,
            ),
    );
  }
}
