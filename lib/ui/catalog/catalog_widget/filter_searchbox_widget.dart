import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/providers/catalog_provider.dart';
import 'package:woedpress_app/ui/catalog/catalog_widget/sort_class.dart';

class BuildFilterAndSearchBox extends StatelessWidget {
  final TextEditingController controller;
  BuildFilterAndSearchBox({
    super.key,
    required this.controller,
  });

  final List<SortBy> _sortByOptions = [
    SortBy('popularity', 'محبوبیت', 'asc'),
    SortBy('modified', 'قدیمی ترین', 'asc'),
    SortBy('price', 'قیمت : از زیاد به کم', 'desc'),
    SortBy('price', 'قیمت : از کم به زیاد', 'asc'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 50.0,
      margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                style: const TextStyle(
                  fontFamily: 'iranSans',
                  fontSize: 14.0,
                ),
                controller: controller,
                textAlign: TextAlign.justify,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 12.0),
                  alignLabelWithHint: true,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Constants.blackColor.withOpacity(0.6),
                  ),
                  hintText: 'جستجو',
                  hintStyle: const TextStyle(
                    fontFamily: 'iranSans',
                    fontSize: 14.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Constants.primaryColor.withOpacity(0.1),
                  filled: true,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15.0),
          Container(
            decoration: BoxDecoration(
              color: Constants.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(9.0),
            ),
            child: PopupMenuButton(
              onSelected: (sortBy) {
                CatalogProvider productList =
                    Provider.of<CatalogProvider>(context, listen: false);
                productList.initializeData();
                productList.setSortOrder(sortBy);
                productList.page = 1;
                productList.fetchProducts(productList.page);
              },
              itemBuilder: (context) {
                return _sortByOptions.map(
                  (item) {
                    return PopupMenuItem(
                      value: item,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          item.text.toString(),
                          style: const TextStyle(fontFamily: 'Lalezar'),
                          textDirection: TextDirection.rtl,
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
    );
  }
}
