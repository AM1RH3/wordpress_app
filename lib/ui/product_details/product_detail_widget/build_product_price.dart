import 'package:flutter/material.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/ui/utils/extensions.dart';

class BuildProductPrice extends StatelessWidget {
  final String? productPrice;
  const BuildProductPrice({
    super.key,
    this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // const SizedBox(width: 5),
        // NABEGHEHA.COM
        SizedBox(
            height: 19.0,
            child: Image.asset('assets/images/PriceUnit-green.png')),
        const SizedBox(width: 5.0),
        Text(
          Constants.numberFormat.format(int.parse('$productPrice')).farsiNumber,
          style: TextStyle(
            fontFamily: 'Vazir',
            color: Constants.blackColor,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ],
    );
  }
}
