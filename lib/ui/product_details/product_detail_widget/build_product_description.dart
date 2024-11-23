import 'package:flutter/material.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/ui/utils/extensions.dart';

class BuildProductDescription extends StatelessWidget {
  final String? productDescription;
  const BuildProductDescription({
    // NABEGHEHA.COM
    super.key,
    this.productDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$productDescription'.removeAllHtmlTags,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontFamily: 'iranSans',
        color: Constants.blackColor.withOpacity(0.7),
        height: 1.6,
        fontSize: 18.0,
      ),
    );
  }
}
