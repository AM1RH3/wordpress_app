import 'package:flutter/material.dart';
import 'package:woedpress_app/constants/constants.dart';

class BuildProductName extends StatelessWidget {
  final String? productname;
  const BuildProductName({
    super.key,
    required this.productname,
  });

  @override
  Widget build(BuildContext context) {
    // NABEGHEHA.COM
    return Text(
      '$productname',
      textDirection: TextDirection.rtl,
      style: TextStyle(
        fontFamily: 'Vazir',
        color: Constants.blackColor,
        fontWeight: FontWeight.bold,
        fontSize: 30.0,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
