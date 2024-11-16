import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:provider/provider.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/providers/catalog_provider.dart';
import 'package:woedpress_app/ui/catalog/sort_class.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  NumberFormat numberFormat = NumberFormat.decimalPattern('fa');

  // ignore: prefer_final_fields
  int _page = 1;
  final TextEditingController _searchQuery = TextEditingController();
  ScrollController scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      CatalogProvider productList =
          Provider.of<CatalogProvider>(context, listen: false);
      productList.initializeData();
      productList.setLoadingState(DataStatus.initial);
      productList.fetchProducts(_page);

      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          productList.setLoadingState(DataStatus.loading);
          productList.fetchProducts(++_page);
        }
      });
    });
    _searchQuery.addListener(_onSearchChange);
    super.initState();
  }

  _onSearchChange() {
    CatalogProvider productList =
        Provider.of<CatalogProvider>(context, listen: false);
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 900),
      () {
        productList.initializeData();
        productList.setLoadingState(DataStatus.initial);
        productList.fetchProducts(_page, searchKeyword: _searchQuery.text);
      },
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  final _sortOptions = [
    SortBy('popularity', 'محبوبیت', 'asc'),
    SortBy('date', 'قدیمی ترین ', 'asc'),
    SortBy('price', 'قیمت : بیشتر به کمتر', 'desc'),
    SortBy('price', 'قیمت :کمتر به بیشتر', 'acs'),
  ];

  @override
  Widget build(BuildContext context) {
    bool isLoadMore =
        context.watch<CatalogProvider>().getDataStatus() == DataStatus.loading;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.window,
                    color: Colors.black54,
                  ),
                  Text(
                    'دسته بندی',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Lalezar',
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      style: const TextStyle(fontFamily: 'Lalezar'),
                      cursorColor: Constants.blackColor,
                      controller: _searchQuery,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(top: 10),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Constants.primaryColor,
                          ),
                          hintText: 'جستجو',
                          alignLabelWithHint: true,
                          hintStyle: const TextStyle(fontFamily: 'Lalezar'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: const Color.fromARGB(150, 213, 213, 213),
                          filled: true),
                    ),
                  ),
                ),
                const SizedBox(width: 15.0),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffe6e6ec),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: PopupMenuButton(
                    onSelected: (sortBy) {
                      CatalogProvider productList =
                          Provider.of<CatalogProvider>(context, listen: false);
                      productList.initializeData();
                      productList.setSortOrder(sortBy);
                      _page = 1;
                      productList.fetchProducts(_page);
                    },
                    itemBuilder: (context) {
                      return _sortOptions.map(
                        (item) {
                          return PopupMenuItem(
                            value: item,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                item.text.toString(),
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(fontFamily: 'Lalezar'),
                              ),
                            ),
                          );
                        },
                      ).toList();
                    },
                    icon: const Icon(Icons.tune),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: isLoadMore,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.all(5.0),
              height: 35.0,
              width: 35.0,
              child: const CircularProgressIndicator(),
            ),
          ),
          Consumer<CatalogProvider>(
            builder: (context, productModel, child) {
              if (productModel.allProduct.isNotEmpty) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Flexible(
                    child: GridView.count(
                      scrollDirection: Axis.vertical,
                      controller: scrollController,
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      children: productModel.allProduct.map((e) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Color(0XFFFFFFFF),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Color(0xfff8f8f8),
                                  blurRadius: 15.0,
                                  spreadRadius: 10.0),
                            ],
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 30.0,
                                          backgroundColor:
                                              const Color(0xffe65829)
                                                  .withAlpha(40),
                                          child: Image.network(
                                            e.images![0].src.toString(),
                                            height: 40.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20.0),
                                    Text(
                                      e.name.toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: 'YekanBakh',
                                        fontSize: 23.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${numberFormat.format(int.parse(e.price ?? '0000'))} تومان ',
                                          textDirection: TextDirection.rtl,
                                          style: const TextStyle(
                                            fontFamily: 'Lalezar',
                                            fontSize: 13.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}
