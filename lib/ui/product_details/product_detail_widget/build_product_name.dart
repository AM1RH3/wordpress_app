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
    return Text(
      '$productname',
      // .length > 19 ? '$productname \n' : '$productname',
      textDirection: TextDirection.rtl,
      maxLines: 3,
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
