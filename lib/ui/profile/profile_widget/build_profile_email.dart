import 'package:flutter/material.dart';
import 'package:woedpress_app/constants/constants.dart';

class BuildProfileEmail extends StatelessWidget {
  final String? profileEmail;
  const BuildProfileEmail({
    super.key,
    this.profileEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$profileEmail',
      style: TextStyle(
        color: Constants.blackColor.withOpacity(0.4),
        fontSize: 15.0,
      ),
    );
  }
}
