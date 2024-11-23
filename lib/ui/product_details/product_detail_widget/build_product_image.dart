import 'package:flutter/material.dart';

class BuildProductImage extends StatelessWidget {
  final String? productImage;
  const BuildProductImage({
    super.key,
    // NABEGHEHA.COM
    this.productImage,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -60.0,
      left: -20.0,
      child: SizedBox(
        height: 350.0,
        child: Image.network(
          '$productImage',
        ),
      ),
    );
  }
}
