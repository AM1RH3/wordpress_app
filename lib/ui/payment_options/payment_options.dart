import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woedpress_app/api/api_service.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/models/zarinpal/zarinpal_request_model.dart';
import 'package:woedpress_app/providers/shop_provider.dart';
import 'package:woedpress_app/ui/payment_options/payment_utils.dart';
import 'package:woedpress_app/ui/payment_webview/peyment_result.dart';
import 'package:woedpress_app/ui/payment_webview/zarinpal_webview.dart';
import 'package:woedpress_app/ui/utils/custom_appbar.dart';
import 'package:woedpress_app/ui/utils/extensions.dart';

class PaymentOptions extends StatefulWidget {
  const PaymentOptions({super.key});
// NABEGHEHA.COM
  @override
  State<PaymentOptions> createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  ZarinpalRequest? zarinpalRequest;
  APIService? apiService;
  late double totalAmount = context.read<ShopProvider>().totalAmount!;

  @override
  void initState() {
    apiService = APIService();
    zarinpalRequest = ZarinpalRequest();
    super.initState();
  }

  Future<ZarinpalRequest?> getZarinpalAuthoriyCode(String totalAmount) async {
    // NABEGHEHA.COM
    return await apiService!.getAuthority(totalAmount);
  }

  zarinpalClick() async {
    await getZarinpalAuthoriyCode(
      totalAmount.toInt().toString(),
    ).then(
      (value) {
        zarinpalRequest = value!;
      },
    );
    String? authorityCode = zarinpalRequest!.data!.authority;
    if (!mounted) return;
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (BuildContext context) => ZarinpalWebView(
          authorityCode: authorityCode,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const BuildCustomAppBar3(appBarTitle: 'روش پرداخت'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 80,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Constants.primaryColor.withOpacity(0.3),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  SizedBox(
                    height: 20.0,
                    child: Image.asset('assets/images/PriceUnit-green.png'),
                  ),
                  const SizedBox(width: 5.0),
                  Text(
                    Constants.numberFormat.format(totalAmount).farsiNumber,
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
                'مبلغ نهایی : ',
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

  Widget _formUI() {
    return SingleChildScrollView(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              // ONLINE PAYMENTS
              const BuildPaymentOptions(
                icon: Icons.payment,
                paymentTitle: 'پرداخت آنلاین',
                paymentDescription: 'از روش‌های زیر یکی را انتخاب کنید',
              ),
              // PAYMENTS METHODS
              const Divider(),
              // const SizedBox(height: 10.0),
              // ZARINPAL
              BuildClickPaymentMethod(
                assetImageUrl: 'assets/images/zarin.png',
                onPressed: zarinpalClick,
                paymentTitle: 'زرین پال',
                paymentDescription: 'پرداخت آنلاین با درگــاه زرین پال',
              ),
              const SizedBox(height: 15.0),
              // NEXTPAY
              BuildClickPaymentMethod(
                assetImageUrl: 'assets/images/nexpay.png',
                onPressed: () {},
                paymentTitle: 'نکست پی',
                paymentDescription: 'پرداخت آنلاین با درگاه نکست پی',
              ),
              const SizedBox(height: 40.0),
              // OFFLINE PAYMENTS
              const BuildPaymentOptions(
                icon: Icons.payments,
                paymentTitle: 'پرداخت آفلاین',
                paymentDescription: 'از روش‌های زیر یکی را انتخاب کنید',
              ),
              const Divider(),
              // const SizedBox(height: 10.0),
              // CASH ON DELEVERY
              BuildClickPaymentMethod(
                assetImageUrl: 'assets/images/cod.png',
                onPressed: () {
                  //! for Test Success Transaction  ***
                  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                      CupertinoPageRoute(
                    builder: (context) {
                      return const ZarinpalSuccess(
                        refID: 30058,
                      );
                    },
                  ), (route) => false);
                  //! for Test Success Transaction ***
                },
                paymentTitle: 'پرداخت در محل',
                paymentDescription: 'پرداخت درب منزل با دستگاه کارت خوان',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
