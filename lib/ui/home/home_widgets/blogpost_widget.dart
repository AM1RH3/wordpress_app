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
// NABEGHEHA.COM
  @override
  Widget build(BuildContext context) {
    return Consumer<ShopProvider>(
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          height: size.height * 0.3,
          child: value.isLoadingPosts
              ? Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Constants.primaryColor,
                    size: 50,
                  ),
                )
              : ListView.builder(
                  itemCount: value.wordpressPosts.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Constants.primaryColor.withOpacity(0.1),
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
                                    color:
                                        Constants.primaryColor.withOpacity(0.8),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                // NABEGHEHA.COM
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
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                          fontFamily: 'Lalezar',
                                        ),
                                      ),
                                      Text(
                                        // inja
                                        'پست وبلاگ',
                                        style: TextStyle(
                                          fontSize: 18.0,
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
