import 'package:flutter/material.dart';
import 'package:woedpress_app/constants/constants.dart';

class BuildProfilePic extends StatelessWidget {
  final String? userAvatar;
  const BuildProfilePic({
    super.key,
    this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      // NABEGHEHA.COM
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Constants.primaryColor.withOpacity(0.5),
          width: 5.0,
        ),
      ),
      child: CircleAvatar(
        radius: 60.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(
          '$userAvatar',
        ),
      ),
    );
  }
}
