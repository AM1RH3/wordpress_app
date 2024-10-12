import 'package:flutter/material.dart';
import 'package:woedpress_app/constants/constants.dart';

class BuildCustomAppBar extends StatelessWidget {
  final String appBarTitle;
  const BuildCustomAppBar({
    required this.appBarTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            color: Constants.blackColor,
            Icons.notifications,
            size: 30.0,
          ),
          Text(
            appBarTitle,
            style: TextStyle(
              color: Constants.blackColor,
              fontFamily: 'Lalezar',
              fontSize: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}

class BuildCustomAppBar2 extends StatelessWidget {
  final String appBarTitle;
  const BuildCustomAppBar2({
    required this.appBarTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 3),
            child: IconButton(
              color: Constants.blackColor,
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 27.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Text(
            appBarTitle,
            style: TextStyle(
              color: Constants.blackColor,
              fontFamily: 'Lalezar',
              fontSize: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}
