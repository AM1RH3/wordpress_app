import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:woedpress_app/db/shared_pr_db.dart';
import 'package:woedpress_app/providers/shop_provider.dart';
import 'package:woedpress_app/ui/login/login_page.dart';
import 'package:woedpress_app/ui/profile/orders_page.dart';
import 'package:woedpress_app/ui/profile/profile_widget.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/ui/root/root_page.dart';

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
    return FutureBuilder(
      future: SharedService.isLoggedin(),
      builder: (BuildContext context, AsyncSnapshot<bool> loginModel) {
        if (loginModel.hasData && loginModel.data!) {
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
                          onPressed: () {
                            SharedService.logOut().then(
                              (value) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    PageTransition(
                                      child: const RootPage(),
                                      type: PageTransitionType.fade,
                                    ),
                                    (route) => false);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
