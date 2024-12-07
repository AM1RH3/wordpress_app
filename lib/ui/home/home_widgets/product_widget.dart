import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/providers/shop_provider.dart';
import 'package:woedpress_app/ui/product_details/product_detail.dart';
import 'package:woedpress_app/ui/utils/extensions.dart';

class BuildProduct extends StatelessWidget {
  final Size size;
// NABEGHEHA.COM
  const BuildProduct({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopProvider>(
      builder: (context, value, child) {
        return SizedBox(
          height: size.height * 0.3,
          child: value.isLoading
              ? Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Constants.primaryColor,
                    size: 50,
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  itemCount: value.productByCategory.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  reverse: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        // NABEGHEHA.COM
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (BuildContext context) {
                              return ProductDetail(
                                product: value.productByCategory[index],
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        width: 280.0,
                        margin: const EdgeInsets.symmetric(horizontal: 18.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Constants.primaryColor,
                            width: 1.5,
                          ),
                          // color: Constants.primaryColor.withOpacity(0.8),
                          color: const Color.fromARGB(255, 254, 247, 255),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.5,
                              blurRadius: 10,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 10.0,
                              right: 20.0,
                              child: Container(
                                height: 40.0,
                                width: 40.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(80.0),
                                ),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.favorite_border_outlined,
                                    color: Constants.primaryColor,
                                    size: 20.0,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 50.0,
                              right: 50.0,
                              top: 50.0,
                              bottom: 50.0,
                              //inja
                              child: Image.network(
                                '${value.productByCategory[index].images?[0].src}',
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              bottom: 15.0,
                              left: 20.0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 2.0),
                                decoration: BoxDecoration(
                                  color: Colors.white10,
                                  borderRadius: BorderRadius.circular(
                                    20.0,
                                  ),
                                ),
                                child: Text(
                                  '${Constants.numberFormat.format(
                                    int.parse(
                                      value.productByCategory[index].price
                                          .toString(),
                                    ),
                                  )} تومان'
                                      .farsiNumber,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    color: Constants.primaryColor,
                                    fontSize: 12.0,
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
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // Text(
                                  //   // inja
                                  //   value.productByCategory[index]
                                  //       .categories![0].name
                                  //       .toString(),
                                  //   style: const TextStyle(
                                  //     fontFamily: 'Lalezar',
                                  //     color: Colors.black87,
                                  //     fontSize: 14.0,
                                  //   ),
                                  // ),
                                  Text(
                                    // inja
                                    value.productByCategory[index].name
                                        .toString(),
                                    textDirection: TextDirection.rtl,
                                    style: const TextStyle(
                                      fontFamily: 'Lalezar',
                                      // NABEGHEHA.COM
                                      color: Colors.black87,
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
        );
      },
    );
  }
}
