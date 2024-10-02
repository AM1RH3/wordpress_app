import 'package:flutter/material.dart';
import 'package:woedpress_app/constants/constants.dart';

class CustomDialogBox {
  static void showMessage(
    BuildContext context,
    String title,
    String message,
    String buttonText,
    final VoidCallback onPressed,
  ) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: AlertDialog(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 15.0,
              ),
              title: Text(
                title,
                style: const TextStyle(fontFamily: 'Lalezar'),
              ),
              content: SingleChildScrollView(
                child: Text(
                  message,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontFamily: 'YekanBakh',
                    fontSize: 16.0,
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: onPressed,
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontFamily: 'YekanBakh',
                      color: Constants.primaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
