import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:woedpress_app/api/api_service.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/models/woocommerce/order_model.dart';
import 'package:woedpress_app/models/zarinpal/zainpal_verify_model.dart';
import 'package:woedpress_app/providers/shop_provider.dart';
import 'package:woedpress_app/ui/payment_webview/peyment_result.dart';
import 'package:woedpress_app/ui/utils/custom_appbar.dart';

class ZarinpalWebView extends StatefulWidget {
  final String? authorityCode;
  const ZarinpalWebView({
    super.key,
    this.authorityCode,
  });

  @override
  State<ZarinpalWebView> createState() => _ZarinpalWebViewState();
}

class _ZarinpalWebViewState extends State<ZarinpalWebView> {
  late InAppWebViewController webView;

  String url = '';
  double progress = 0;
  APIService? apiService;
  ZarinpalVerify? zarinpalVerify;
  late int totalAmount = context.read<ShopProvider>().totalAmount!.toInt();

  @override
  void initState() {
    apiService = APIService();
    zarinpalVerify = zarinpalVerify!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const BuildCustomAppBar(appBarTitle: 'درگاه  زرین‌پال'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(
            'https://www.zarinpal.com/pg/StartPay/${widget.authorityCode}',
          ),
        ),
        // ignore: deprecated_member_use
        initialOptions: InAppWebViewGroupOptions(
          // ignore: deprecated_member_use
          android: AndroidInAppWebViewOptions(textZoom: 120),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          webView = controller;
          // ignore: deprecated_member_use
          webView.clearCache();
        },
        onLoadStart: (InAppWebViewController controller, Uri? url) async {
          String uriToString = url.toString();
          if (uriToString.contains(ZarinpalInfo.zarinpalCallBackURL)) {
            final Uri uri = Uri.parse(uriToString);
            final String? authority = uri.queryParameters['Authority'];
            await apiService?.verifyPayment(totalAmount, authority!).then(
              (value) {
                zarinpalVerify = value;
              },
            );
            if (!mounted) return;
            ShopProvider orderProvider =
                Provider.of<ShopProvider>(context, listen: false);
            OrderModel orderModel = OrderModel();
            orderModel.paymentMethod = 'آنلاین';
            orderModel.paymentMethodTitle = 'پرداخت از طریق درگاه زرین پال';
            orderModel.setPaid = true;
            orderModel.transactionId =
                'کد رهگیری پرداخت زرین پال : ${(zarinpalVerify?.data?.refId).toString()}';
            orderProvider.processOrder(orderModel);
            Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(
              builder: (BuildContext context) {
                return ZarinpalSuccess(refID: zarinpalVerify?.data?.refId);
              },
            ), (route) => false);
          }
        },
      ),
    );
  }
}
 // ************************ تا قسمت 65 - دقیقه 5:42 نگاه کردم ******************** 