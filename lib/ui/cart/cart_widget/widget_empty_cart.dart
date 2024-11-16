import 'package:flutter/material.dart';

class BuildEmptyCart extends StatelessWidget {
  const BuildEmptyCart({super.key});
// NABEGHEHA.COM
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100.0,
              child: Image.asset('assets/images/add-cart.png'),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'سبد خرید تار عنکبوت بسته است',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 20.0,
                fontFamily: 'Lalezar',
              ),
            )
          ],
        ),
      ),
    );
  }
}
