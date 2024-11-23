import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:woedpress_app/providers/shop_provider.dart';
import 'package:woedpress_app/ui/home/home_widgets/blogpost_title_widget.dart';
import 'package:woedpress_app/ui/home/home_widgets/blogpost_widget.dart';
import 'package:woedpress_app/ui/home/home_widgets/category_widget.dart';
import 'package:woedpress_app/ui/home/home_widgets/product_widget.dart';
import 'package:woedpress_app/ui/home/home_widgets/searchbox_widget.dart';
import 'package:woedpress_app/ui/utils/custom_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      ShopProvider shopProvider =
          Provider.of<ShopProvider>(context, listen: false);
      shopProvider.getProductsByCategory('20');
      shopProvider.getAllCategoryNames();
      shopProvider.getAllWordpressPosts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        // NABEGHEHA.COM
        automaticallyImplyLeading: false,
        title: const BuildCustomAppBar(appBarTitle: 'خانه'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search Box
            BuildSearchBox(size: size),
            // Category
            BuildCategory(size: size),
            // Product One
            BuildProduct(size: size),
            // BLOG POST TITLE
            const BuildBlogPostTitle(title: 'مطالب وبلاگ'),
            // BLOG POSTS
            BuildBlogPost(size: size),
          ],
        ),
      ),
    );
  }
}
