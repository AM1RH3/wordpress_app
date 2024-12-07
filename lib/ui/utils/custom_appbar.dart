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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon(
          //   color: Constants.blackColor,
          //   Icons.favorite_outline,
          //   size: 30.0,
          // ),
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
      padding: const EdgeInsets.only(top: 30.0, bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                color: Constants.blackColor,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 27.0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                appBarTitle,
                style: TextStyle(
                  color: Constants.blackColor,
                  fontFamily: 'Lalezar',
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(width: 35),
              IconButton(
                color: Constants.blackColor,
                icon: const Icon(
                  Icons.favorite_border,
                  color: Color.fromARGB(255, 18, 143, 200),
                  size: 27.0,
                ),
                onPressed: () {},
              ),
              IconButton(
                color: Constants.blackColor,
                icon: const Icon(
                  Icons.more_vert_rounded,
                  size: 27.0,
                ),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}

class BuildCustomAppBar3 extends StatelessWidget {
  final String appBarTitle;
  const BuildCustomAppBar3({
    required this.appBarTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                color: Constants.blackColor,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 27.0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                appBarTitle,
                style: TextStyle(
                  color: Constants.blackColor,
                  fontFamily: 'Lalezar',
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(width: 15),
            ],
          )
        ],
      ),
    );
  }
}
