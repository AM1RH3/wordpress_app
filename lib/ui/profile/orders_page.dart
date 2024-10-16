import 'package:flutter/material.dart';
import 'package:woedpress_app/constants/constants.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 90.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              // X Button
              child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Constants.primaryColor.withOpacity(0.15),
                ),
                child: Icon(
                  Icons.close,
                  color: Constants.primaryColor,
                ),
              ),
            ),
            Text(
              'سفارش ها',
            ),
          ],
        ),
      ),
    );
  }
}
