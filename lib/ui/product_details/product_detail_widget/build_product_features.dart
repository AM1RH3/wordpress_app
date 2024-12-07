import 'package:flutter/material.dart';
import 'package:woedpress_app/ui/product_details/product_detail_widget/widget_product_feature.dart';

class BuildProductFeatures extends StatelessWidget {
  const BuildProductFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      // NABEGHEHA.COM
      top: 0.0,
      right: 0.0,
      child: SizedBox(
        // height: 20.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ProductFeature(
              title: ':رنگ های موجود',
              feature: '▮',
              pColor1: Colors.black,
              pColor2: Colors.red,
              pColor3: Colors.green,
            ),

            // ProductFeature(
            //   title: 'dfgdg',
            //   feature: 'dfg',
            // ),
            // ProductFeature(
            //   title: 'dfg',
            //   feature: 'dfgd',
            // ),
          ],
        ),
      ),
    );
  }
}
