import 'package:flutter/material.dart';
import 'package:woedpress_app/constants/constants.dart';

class BuildOptions extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onPressed;

  const BuildOptions({
    super.key,
    required this.title,
    required this.icon,
    this.onPressed,
  });
  // NABEGHEHA.COM

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.arrow_back_ios,
              size: 16,
              color: Constants.blackColor.withOpacity(0.4),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  // NABEGHEHA.COM
                  style: TextStyle(
                    fontFamily: 'IranSans',
                    color: Constants.blackColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 5.0),
                Icon(
                  icon,
                  color: Constants.blackColor.withOpacity(0.5),
                  size: 23.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
