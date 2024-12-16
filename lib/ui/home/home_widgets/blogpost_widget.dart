import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/providers/shop_provider.dart';

class BuildBlogPost extends StatelessWidget {
  final Size size;
  const BuildBlogPost({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopProvider>(
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          height: size.height * 0.3,
          child: value.isLoadingPosts
              ? Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Constants.primaryColor,
                    size: 50,
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  itemCount: value.wordpressPosts.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: const Offset(0, 1),
                            ),
                          ],
                          color: const Color.fromARGB(255, 254, 247, 255)
                          // .withOpacity(0.05)
                          ,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height: 80.0,
                        width: size.width,
                        margin: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          top: 10.0,
                          right: 10.0,
                          bottom: 10.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 5.0),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "مشاهده",
                                    style: TextStyle(
                                      fontFamily: 'Lalezar',
                                      color: Constants.primaryColor,
                                      fontSize: 20.0,
                                    ),
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
                                    color:
                                        Constants.primaryColor.withOpacity(0.7),
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
                                      Icons.whatshot_outlined,
                                      size: 33.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 5.0,
                                  right: 80.0,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        // inja
                                        value.wordpressPosts[index].title
                                            .toString(),
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: 'Lalezar',
                                          color: Constants.primaryColor,
                                        ),
                                      ),
                                      Text(
                                        // inja
                                        value.wordpressPosts[index].content
                                            .toString(),
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: 'Lalezar',
                                          color: Constants.blackColor,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
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
