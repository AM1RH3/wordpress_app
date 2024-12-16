import 'package:flutter/material.dart';

class BuildProductImage extends StatelessWidget {
  final String? productImage;
  const BuildProductImage({
    super.key,
    this.productImage,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
      bottom: size.height * 0.43,
      top: 10.0,
      left: 5.0,
      right: 5.0,
      child: SizedBox(
        height: 350.0,
        child: Image.network(
          '$productImage',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
