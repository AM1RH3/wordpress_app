import 'package:flutter/material.dart';
import 'package:woedpress_app/constants/constants.dart';

class BuildProfileName extends StatelessWidget {
  final String? firstName;
  const BuildProfileName({
    super.key,
    this.firstName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$firstName',
          style: TextStyle(
            color: Constants.blackColor,
            fontSize: 20.0,
            fontFamily: 'Lalezar',
          ),
        ),
        const SizedBox(width: 5.0),
        SizedBox(
          height: 20.0,
          child: Image.asset(
            'assets/images/verified.png',
          ),
        ),
      ],
    );
  }
}
