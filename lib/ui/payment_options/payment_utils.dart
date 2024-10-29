import 'package:flutter/material.dart';
import 'package:woedpress_app/constants/constants.dart';

class BuildPaymentOptions extends StatelessWidget {
  final String paymentTitle;
  final String paymentDescription;
  final IconData icon;

  const BuildPaymentOptions({
    required this.icon,
    required this.paymentTitle,
    required this.paymentDescription,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
        leading: Icon(
          icon,
          color: Constants.primaryColor,
          size: 45.0,
        ),
        // NABEGHEHA.COM
        title: Text(
          paymentTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontFamily: 'YekanBakh',
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          paymentDescription,
          style: const TextStyle(
            fontFamily: 'YekanBakh',
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}

class BuildClickPaymentMethod extends StatelessWidget {
  final String assetImageUrl;
  final String paymentTitle;
  final String paymentDescription;
  final VoidCallback onPressed;

  const BuildClickPaymentMethod({
    required this.assetImageUrl,
    required this.paymentTitle,
    required this.paymentDescription,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Constants.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          // NABEGHEHA.COM
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 45.0,
              width: 40.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                ),
                image: DecorationImage(
                  image: AssetImage(assetImageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 15.0),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          paymentTitle,
                          style: const TextStyle(
                            fontFamily: 'iranSans',
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          paymentDescription,
                          style: const TextStyle(
                            fontFamily: 'iranSans',
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
