import 'package:flutter/material.dart';
import 'package:woedpress_app/constants/constants.dart';

class ProductFeature extends StatelessWidget {
  final String title;
  final String feature;
  final Color pColor1;
  final Color pColor2;
  final Color pColor3;
  const ProductFeature({
    super.key,
    required this.title,
    required this.feature,
    required this.pColor1,
    required this.pColor2,
    required this.pColor3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Constants.blackColor,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lalezar',
          ),
        ),
        Text(
          feature,
          style: TextStyle(
            color: pColor1,
            fontSize: 50.0,
            height: 0.4,
            fontWeight: FontWeight.bold,
            // fontFamily: 'Lalezar',
          ),
        ),
        Text(
          feature,
          style: TextStyle(
            color: pColor2,
            fontSize: 50.0,
            height: 0.4,
            fontWeight: FontWeight.bold,
            // fontFamily: 'Lalezar',
          ),
        ),
        Text(
          feature,
          style: TextStyle(
            color: pColor3,
            fontSize: 50.0,
            height: 0.4,
            fontWeight: FontWeight.bold,
            // fontFamily: 'Lalezar',
          ),
        ),
      ],
    );
  }
}
