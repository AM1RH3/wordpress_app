import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:provider/provider.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/models/woocommerce/product_model.dart';
import 'package:woedpress_app/providers/shop_provider.dart';
import 'package:woedpress_app/ui/product_details/product_detail.dart';
import 'package:woedpress_app/ui/utils/custom_appbar.dart';
import 'package:woedpress_app/ui/utils/extensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _RootPageState();
}

class _RootPageState extends State<HomePage> {
  int selectedIndex = 0;

  bool toggleIsFavorite(bool isFavorites) {
    return !isFavorites;
  }

  List<Categories> productsCategoryNames = <Categories>[
    Categories(orderId: 1, id: 16, name: '|دسته بندی نشده|'),
    Categories(orderId: 2, id: 19, name: ' | آموزش |'),
    Categories(orderId: 3, id: 20, name: ' | امنیت |'),
    Categories(orderId: 4, id: 21, name: ' | برنامه نویسی |'),
    Categories(orderId: 5, id: 22, name: ' | وبلاگ |'),
  ];
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      ShopProvider shopProvider =
          Provider.of<ShopProvider>(context, listen: false);
      // productList.getAllProducts();
      shopProvider.getAllCategoryNames();
      shopProvider.getProductsByCategory('19');
      shopProvider.getAllWordpressPosts();
    });
    productsCategoryNames.sort(
      (a, b) => a.orderId!.compareTo(b.orderId as num),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat = NumberFormat.decimalPattern('fa');
    Size size = MediaQuery.of(context).size;

    return Consumer<ShopProvider>(
      builder: (context, value, child) {
        // if (value.isLoading) {
        //   return const Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const BuildCustomAppBar(appBarTitle: 'خانه'),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                //! *************************************************** Search Box *******************************************
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      width: size.width * 0.93,
                      decoration: BoxDecoration(
                          color: Constants.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.mic,
                            color: Constants.blackColor.withOpacity(0.6),
                          ),
                          const Expanded(
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextField(
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(right: 8.0, left: 8.0),
                                    hintText: 'جستجو...',
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: 'iranSans',
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.search,
                            color: Constants.blackColor.withOpacity(0.6),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //! ************************************************   << Category >>   ******************************************
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 10.0),
                  height: 70,
                  width: size.width,
                  child: ListView.builder(
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: productsCategoryNames.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            final catID = productsCategoryNames[index].id;
                            setState(() {
                              selectedIndex = index;
                              value.getProductsByCategory(catID.toString());
                            });
                          },
                          child: Text(
                            productsCategoryNames[index].name.toString(),
                            style: TextStyle(
                              fontFamily: 'iranSans',
                              fontSize: 16.0,
                              fontWeight: selectedIndex == index
                                  ? FontWeight.bold
                                  : FontWeight.w300,
                              color: selectedIndex == index
                                  ? Constants.primaryColor
                                  : Constants.blackColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                //!  *****************************************  <<  Product One >>   ********************************************
                SizedBox(
                  height: size.height * 0.3,
                  child: value.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          itemCount: value.productByCategory.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: ProductDetail(
                                      product: value.productByCategory[index],
                                    ),
                                    type: PageTransitionType.fade,
                                  ),
                                );
                              },
                              child: Container(
                                width: 220.0,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 18.0),
                                decoration: BoxDecoration(
                                  color:
                                      Constants.primaryColor.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 10,
                                      right: 20.0,
                                      child: Container(
                                        height: 40.0,
                                        width: 40.0,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.favorite_border_outlined,
                                            color: Constants.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 40.0,
                                      right: 40.0,
                                      top: 65.0,
                                      bottom: 65.0,
                                      child: Image.network(
                                        value.productByCategory[index]
                                            .images![0].src
                                            .toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 15.0,
                                      left: 20.0,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 2.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadiusDirectional.circular(
                                                  20.0),
                                        ),
                                        child: Text(
                                          '${numberFormat.format(int.parse(value.productByCategory[index].price.toString()))} تومان'
                                              .farsiNumber,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                            color: Constants.primaryColor,
                                            fontSize: 12,
                                            fontFamily: 'Lalezar',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 15.0,
                                      right: 20.0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            value.productByCategory[index]
                                                .categories![0].name
                                                .toString(),
                                            style: const TextStyle(
                                              fontFamily: 'Lalezar',
                                              color: Colors.white60,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          Text(
                                            value.productByCategory[index].name
                                                .toString(),
                                            style: const TextStyle(
                                              fontFamily: 'Lalezar',
                                              color: Colors.white70,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
                //! ******************************************  <<   Weblog text's - Text  >>   ************************
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(
                    right: 18.0,
                    bottom: 15.0,
                    top: 20.0,
                  ),
                  child: const Text(
                    ' مطالب وبلاگ',
                    style: TextStyle(
                      fontFamily: 'Lalezar',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                //! **********************************   <<  Weblog Post's- Product Two >>  *****************************
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  height: size.height * 0.3,
                  child: value.isLoadingPosts
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: value.wordpressPosts.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      Constants.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                height: 80.0,
                                width: size.width,
                                margin: const EdgeInsets.only(
                                  bottom: 10.0,
                                  top: 10.0,
                                ),
                                padding: const EdgeInsets.only(
                                  bottom: 10.0,
                                  top: 10.0,
                                  right: 12.0,
                                  left: 12.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(width: 5.0),
                                        Text(
                                          "کلیک کنید",
                                          style: TextStyle(
                                            fontFamily: 'Lalezar',
                                            color: Constants.primaryColor,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          width: 60.0,
                                          height: 60.0,
                                          decoration: BoxDecoration(
                                            color: Constants.primaryColor
                                                .withOpacity(0.8),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const Positioned(
                                          bottom: -10.0,
                                          left: 0,
                                          right: 0,
                                          child: SizedBox(
                                              height: 80.0,
                                              child: Icon(
                                                Icons.article,
                                                size: 33.0,
                                                color: Colors.white,
                                              )),
                                        ),
                                        Positioned(
                                          bottom: 5.0,
                                          right: 80.0,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                value
                                                    .wordpressPosts[index].title
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 13.0,
                                                  fontFamily: 'Lalezar',
                                                ),
                                              ),
                                              Text(
                                                'پست وبلاگ',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontFamily: 'Lalezar',
                                                  color: Constants.blackColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
