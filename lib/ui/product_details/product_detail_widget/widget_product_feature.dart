import 'package:flutter/material.dart';
import 'package:woedpress_app/constants/constants.dart';

class ProductFeature extends StatelessWidget {
  final String title;
  final String feature;
  const ProductFeature({
    Key? key,
    required this.title,
    required this.feature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // NABEGHEHA.COM
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
            color: Constants.primaryColor,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lalezar',
          ),
        ),
      ],
    );
  }
}
