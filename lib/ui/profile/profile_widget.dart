import 'package:flutter/material.dart';
import 'package:woedpress_app/constants/constants.dart';

class BuildOptions extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;
  const BuildOptions({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
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
                  style: TextStyle(
                    fontFamily: 'iranSans',
                    color: Constants.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 5),
                Icon(
                  icon,
                  color: Constants.blackColor.withOpacity(0.5),
                  size: 23,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
