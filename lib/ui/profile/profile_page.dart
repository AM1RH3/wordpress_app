import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:woedpress_app/providers/shop_provider.dart';
import 'package:woedpress_app/ui/profile/orders_page.dart';
import 'package:woedpress_app/ui/profile/profile_widget.dart';
import 'package:woedpress_app/constants/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _RootPageState();
}

class _RootPageState extends State<ProfilePage> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      ShopProvider userDetail =
          Provider.of<ShopProvider>(context, listen: false);
      userDetail.fetchShippingDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            //!                         ******** Profile Image ********
            Container(
              width: 150.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Constants.primaryColor.withOpacity(0.5),
                  width: 5.0,
                ),
              ),
              child: CircleAvatar(
                radius: 60.0,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(
                  '${context.watch<ShopProvider>().customerDetailsModel?.avatarURL}',
                ),
              ),
            ),
            //!                        ******** END Profile Image ********
            const SizedBox(height: 15),
            //!                          ******** Profile Name ********

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${context.watch<ShopProvider>().customerDetailsModel?.firstName}',
                  style: TextStyle(
                    fontFamily: 'YekanBakh',
                    fontSize: 30,
                    color: Constants.blackColor,
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  height: 20.0,
                  child: Image.asset('assets/images/verified.png'),
                ),
              ],
            ),
            //!                        ******** END Profile Name ********
            const SizedBox(height: 5),
            //!                         ******** Profile emale ********
            Text(
              '${context.watch<ShopProvider>().customerDetailsModel?.email}',
              style: TextStyle(
                color: Constants.blackColor.withOpacity(0.4),
                fontSize: 16.0,
              ),
            ),
            //!                        ******** END Profile email ********
            const SizedBox(height: 10),
            //!                        ******** Profile Options ********
            SizedBox(
              height: size.height * 0.4,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BuildOptions(
                    title: 'پروفایل من',
                    icon: Icons.person,
                    onPressed: () {},
                  ),
                  BuildOptions(
                    title: 'سفارشات من',
                    icon: Icons.shopping_cart,
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: const OrdersPage(),
                          type: PageTransitionType.fade,
                        ),
                      );
                    },
                  ),
                  BuildOptions(
                    title: 'اطلاع رسانی ها',
                    icon: Icons.notifications,
                    onPressed: () {},
                  ),
                  BuildOptions(
                    title: 'شبکه های اجتماعی',
                    icon: Icons.share,
                    onPressed: () {},
                  ),
                  BuildOptions(
                    title: 'خروج',
                    icon: Icons.logout,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
