import 'package:flutter/material.dart';

class BuildBlogPostTitle extends StatelessWidget {
  final String title;
  const BuildBlogPostTitle({
    super.key,
    required this.title,
  });
// NABEGHEHA.COM
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 18.0, bottom: 15.0, top: 20.0),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Lalezar',
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
