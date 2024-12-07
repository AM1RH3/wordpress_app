import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/providers/catalog_provider.dart';
import 'package:woedpress_app/ui/catalog/catalog_widget/build_products_widget.dart';
import 'package:woedpress_app/ui/catalog/catalog_widget/filter_searchbox_widget.dart';
import 'package:woedpress_app/ui/utils/custom_appbar.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});
// NABEGHEHA.COM
  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  // CONTROLERS
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchQuery = TextEditingController();

  // VARIABLES
  Timer? _debounce;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      CatalogProvider productList =
          // ignore: use_build_context_synchronously
          Provider.of<CatalogProvider>(context, listen: false);
      productList.initializeData();
      productList.setLoadingState(DataStatus.initial);
      productList.fetchProducts(productList.page);
      _scrollController.addListener(() {
        if (_scrollController.hasClients) {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            productList.setLoadingState(DataStatus.loading);
            productList.fetchProducts(++productList.page);
            // NABEGHEHA.COM
          }
        }
      });
    });
    _searchQuery.addListener(_onSearchChange);
    super.initState();
  }

  // SEARCHBOX METHOD
  _onSearchChange() {
    CatalogProvider productList =
        Provider.of<CatalogProvider>(context, listen: false);
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      productList.initializeData();
      productList.setLoadingState(DataStatus.initial);
      productList.fetchProducts(productList.page,
          searchKeyword: _searchQuery.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLoadMore =
        context.watch<CatalogProvider>().getDataStatus() == DataStatus.loading;
    bool buildOrNot = context.watch<CatalogProvider>().allProduct.isNotEmpty !=
            false &&
        context.watch<CatalogProvider>().getDataStatus() != DataStatus.initial;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const BuildCustomAppBar(appBarTitle: 'فروشگاه'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          BuildFilterAndSearchBox(controller: _searchQuery),
          const SizedBox(height: 10),
          buildOrNot
              ? BuildCatalogProducts(scrollController: _scrollController)
              : Expanded(
                  child: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Constants.primaryColor,
                      size: 50,
                    ),
                  ),
                ),
          // NABEGHEHA.COM
          Visibility(
            visible: isLoadMore,
            child: Container(
              padding: const EdgeInsets.all(5.0),
              height: 35.0,
              width: 35.0,
              child: LoadingAnimationWidget.fallingDot(
                color: Constants.primaryColor,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
