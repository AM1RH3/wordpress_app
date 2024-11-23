import 'package:flutter/material.dart';
import 'package:woedpress_app/constants/constants.dart';

class BuildCustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  const BuildCustomButton({
    super.key,
    this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Constants.primaryColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 10.0,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Lalezar',
          fontSize: 15.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
