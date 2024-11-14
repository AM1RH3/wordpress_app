import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/ui/cart/cart_page.dart';
import 'package:woedpress_app/ui/catalog/catalog_page.dart';
import 'package:woedpress_app/ui/home/home_page.dart';
import 'package:woedpress_app/ui/profile/profile_page.dart';
import 'package:woedpress_app/ui/utils/custom_appbar.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int bottomIndex = 0;
  // final PersistentTabController _controller =
  //     PersistentTabController(initialIndex: 0);

  // List<Plant> favorites = [];
  // List<Plant> myCart = [];

//! قبلا بصورت لیست بود ولی چون ایراد میگرفت بصورت پرانتز و کرلی براکت کردیم که بصورت ریترن تایپ لیست ویجت کار کنه
  List<Widget> pages() {
    return const [
      HomePage(),
      CatalogPage(),
      CartPage(),
      ProfilePage(),
    ];
  }

  // List<PersistentBottomNavBarItem> _navBarItems() {
  //   return [
  //     PersistentBottomNavBarItem(
  //       icon: const Icon(Icons.home),
  //       title: 'HOME',
  //       activeColorPrimary: Constants.primaryColor,
  //       inactiveColorPrimary: Constants.blackColor.withOpacity(0.5),
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: const Icon(Icons.apps_rounded),
  //       title: 'CATALOG',
  //       activeColorPrimary: Constants.primaryColor,
  //       inactiveColorPrimary: Constants.blackColor.withOpacity(0.5),
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: const Icon(Icons.shopping_cart_outlined),
  //       title: 'CART',
  //       activeColorPrimary: Constants.primaryColor,
  //       inactiveColorPrimary: Constants.blackColor.withOpacity(0.5),
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: const Icon(Icons.person_3),
  //       title: 'PROFILE',
  //       activeColorPrimary: Constants.primaryColor,
  //       inactiveColorPrimary: Constants.blackColor.withOpacity(0.5),
  //     ),
  //   ];
  // }

  List<String> appBarTitle = [
    'خانه',
    'دسته بندی',
    'سبد خرید ',
    'پروفایل',
  ];

  List<IconData> iconList = [
    Icons.home,
    Icons.auto_awesome_mosaic_rounded,
    Icons.shopping_bag_rounded,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const BuildCustomAppBar(appBarTitle: ''),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: IndexedStack(
        index: bottomIndex,
        children: pages(),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
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
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
          autofocus: true,
        ),
      ),
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
      // PersistentTabView(
      //   context,
      //   navBarHeight: 51,
      //   controller: _controller,
      //   screens: pages(),
      //   items: _navBarItems(),
      //   confineToSafeArea: true,
      //   backgroundColor: Colors.white10, // Default is Colors.white.
      //   handleAndroidBackButtonPress: true, // Default is true.
      //   resizeToAvoidBottomInset:
      //       true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      //   stateManagement: true, // Default is true.
      //   hideNavigationBarWhenKeyboardAppears:
      //       true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      //   decoration: NavBarDecoration(
      //     borderRadius: BorderRadius.circular(10.0),
      //     colorBehindNavBar: Colors.white10,
      //   ),
      //   popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
      //   navBarStyle:
      //       NavBarStyle.style12, // Choose the nav bar style with this property.
      // ),
    );
  }
}
