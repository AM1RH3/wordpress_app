import 'package:flutter/material.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/ui/utils/extensions.dart';

class BuildProductDescription extends StatelessWidget {
  String formatText(String text) {
    return text.replaceAll('<p>', '\n').replaceAll('<p/>', '\n');
  }

  final String? productDescription;
  const BuildProductDescription({
    super.key,
    this.productDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        formatText('$productDescription'.removeAllHtmlTags),

        textDirection: TextDirection.rtl,
        // textAlign: TextAlign.justify,
        maxLines: 14,

        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontFamily: 'Vazir',
          color: Constants.blackColor.withOpacity(0.7),
          height: 1,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
