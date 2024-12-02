import 'package:flutter/material.dart';
import 'package:woedpress_app/constants/constants.dart';

class BuildSearchBox extends StatelessWidget {
  const BuildSearchBox({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // NABEGHEHA.COM
      padding: const EdgeInsets.only(top: 20.0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          width: size.width * 0.9,
          decoration: BoxDecoration(
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.2),
            //     spreadRadius: 1,
            //     blurRadius: 10,
            //     offset: const Offset(0, 10),
            //   ),
            // ],
            color: Constants.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.mic,
                color: Constants.blackColor.withOpacity(0.6),
              ),
              const Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    textAlign: TextAlign.start,
                    showCursor: false,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(right: 5.0),
                      hintText: 'جستجو...',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontFamily: 'iranSans',
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
              // NABEGHEHA.COM
              Icon(
                Icons.search,
                color: Constants.blackColor.withOpacity(0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
