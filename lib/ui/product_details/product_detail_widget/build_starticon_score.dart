import 'package:flutter/material.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/ui/utils/extensions.dart';

class BuildStarScore extends StatelessWidget {
  const BuildStarScore({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.star,
          size: 30.0,
          // NABEGHEHA.COM
          color: Constants.primaryColor,
        ),
        Text(
          '4.9'.farsiNumber,
          style: TextStyle(
            fontFamily: 'Lalezar',
            color: Constants.primaryColor,
            fontSize: 23.0,
          ),
        ),
      ],
    );
  }
}
