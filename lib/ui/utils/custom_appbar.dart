import 'package:flutter/material.dart';
import 'package:woedpress_app/constants/constants.dart';

class CustomAppBar extends StatelessWidget {
  final String appBarTitle;
  const CustomAppBar({
    required this.appBarTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50.0,
      left: 20.0,
      right: 20.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Constants.primaryColor.withOpacity(0.15),
              ),
              child: Icon(
                Icons.close,
                color: Constants.primaryColor,
              ),
            ),
          ),
          Text(
            appBarTitle,
            style: TextStyle(
              color: Constants.blackColor,
              fontFamily: 'Lalezar',
              fontSize: 25.0,
            ),
          ),
        ],
      ),
    );
  }
}
