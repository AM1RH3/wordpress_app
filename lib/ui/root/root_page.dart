import 'package:flutter/material.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:woedpress_app/ui/cart/cart_page.dart';
import 'package:woedpress_app/ui/catalog/catalog_page.dart';
import 'package:woedpress_app/ui/home/home_page.dart';
import 'package:woedpress_app/ui/profile/profile_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int bottomIndex = 0;

  // List<Plant> favorites = [];
  // List<Plant> myCart = [];

//! قبلا بصورت لیست بود ولی چون ایراد میگرفت بصورت پرانتز و کرلی براکت کردیم که بصورت ریترن تایپ لیست ویجت کار کنه
  List<Widget> pages() {
    return const [
      HomePage(),
      // FavoritePage(favoritedPlants: favorites), // تبدیلش کردیم به پایینی
      CatalogPage(),
      // CartPage(addedToCartPlants: myCart),
      CartPage(),
      ProfilePage(),
    ];
  }

  List<IconData> iconList = [
    Icons.home,
    Icons.auto_awesome_mosaic_rounded,
    Icons.shopping_bag_rounded,
    Icons.person,
  ];

  List<String> appBarTitle = [
    'خانه',
    'دسته بندی',
    'سبد خرید ',
    'پروفایل',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.notifications,
                color: Constants.blackColor,
                size: 28.0,
              ),
              Text(
                appBarTitle[bottomIndex],
                style: TextStyle(
                    color: Constants.blackColor,
                    fontFamily: 'Lalezar',
                    fontSize: 24.0),
              ),
            ],
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: IndexedStack(
        index: bottomIndex,
        children: pages(),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   PageTransition(
            //       duration: const Duration(milliseconds: 300),
            //       child: const ScanPage(),
            //       type: PageTransitionType.bottomToTop),
            // );
          },
          backgroundColor: Constants.primaryColor,
          child: IconButton(onPressed: () {}, icon: const Icon(Icons.search))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        splashColor: Constants.primaryColor,
        activeColor: Constants.primaryColor,
        activeIndex: bottomIndex,
        inactiveColor: Colors.black.withOpacity(0.5),
        gapLocation: GapLocation.center,
        icons: iconList,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) {
          setState(() {
            bottomIndex = index;

            // final List<Plant> favoritedPlants = Plant.getFavoritedPlants();
            // final List<Plant> addedToCartPlants = Plant.addedToCartPlants();
            // //! با تو (ست) کردن باعث میشه عضو های تکراری نتونن بیان
            // favorites = favoritedPlants.toSet().toList();
            // myCart = addedToCartPlants.toSet().toList();
          });
        },
      ),
    );
  }
}
