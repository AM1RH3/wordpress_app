import 'package:flutter/material.dart';
import 'package:woedpress_app/ui/product_details/product_detail_widget/widget_product_feature.dart';

class BuildProductFeatures extends StatelessWidget {
  const BuildProductFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      // NABEGHEHA.COM
      top: 10.0,
      right: 0.0,
      child: SizedBox(
        height: 200.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ProductFeature(
              title: 'مدرس',
              feature: 'امیرحسین معلمی',
            ),
            ProductFeature(
              title: 'پیشنیاز',
              feature: 'ندارد',
            ),
            ProductFeature(
              title: 'سطح',
              feature: 'پیشرفته',
            ),
          ],
        ),
      ),
    );
  }
}
