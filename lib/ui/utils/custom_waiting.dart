import 'package:flutter/material.dart';

class CustomWaiting extends StatelessWidget {
  const CustomWaiting({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'لطفاً منتظر بمانید.....',
      textDirection: TextDirection.rtl,
      style: TextStyle(
        fontFamily: 'Lalezar',
        fontSize: 20.0,
      ),
    );
  }
}
