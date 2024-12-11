import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woedpress_app/db/secure_db.dart';
import 'package:woedpress_app/ui/profile/order_page/orders_page.dart';
import 'package:woedpress_app/ui/profile/profile_widget/profile_options_widget.dart';
import 'package:woedpress_app/ui/unauthorized/login_check.dart';

class BuildProfileOptions extends StatelessWidget {
  final Size size;
  const BuildProfileOptions({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.4,
      width: size.width,
      child: Column(
        // NABEGHEHA.COM
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const BuildOptions(title: 'پروفایل من', icon: Icons.person),
          BuildOptions(
            title: 'سفارشات من',
            icon: Icons.shopping_cart_rounded,
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) {
                    return const OrdersPage();
                  },
                ),
              );
            },
          ),
          const BuildOptions(title: 'علاقه مندی ها', icon: Icons.favorite),
          const BuildOptions(title: 'ارتباط با ما', icon: Icons.share_rounded),
          BuildOptions(
            title: ' خروج از حساب',
            icon: Icons.logout,
            onPressed: () {
              SecureSorageDB().logOut().then(
                (value) {
                  // NABEGHEHA.COM
                  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                      CupertinoPageRoute(
                    builder: (context) {
                      return const LoginOrNot();
                    },
                  ), (route) => false);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
