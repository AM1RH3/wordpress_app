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
      style: TextStyle(
        fontFamily: 'Lalezar',
        color: Constants.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 30.0,
      ),
    );
  }
}
