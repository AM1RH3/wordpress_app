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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
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
              style: TextStyle(
                color: Constants.blackColor,
                fontFamily: 'Lalezar',
                fontSize: 24.0,
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: 6,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 15.0),
              elevation: 5,
              shadowColor: Colors.black,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          const SizedBox(width: 15.0),
                          const Icon(Icons.receipt),
                          const SizedBox(width: 10.0),
                          const Text(
                            'درحال بررسی ',
                            style: TextStyle(
                              fontFamily: 'Lalezar',
                              fontSize: 20.0,
                            ),
                          ),
                          const SizedBox(width: 210),
                          Image.asset(
                            'assets/images/nexpay.png',
                            height: 40,
                          ),
                        ],
                      ),
                      const Divider(color: Colors.black),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.info_outline_rounded,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                ' شماره سفارش :',
                                style: TextStyle(
                                  fontFamily: 'Lalezar',
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '0002456',
                            style: TextStyle(
                              fontFamily: 'Lalezar',
                              fontSize: 18.0,
                              color: Constants.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.timelapse,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                ' تاریخ  سفارش  : ',
                                style: TextStyle(
                                  fontFamily: 'Lalezar',
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '1403/1/1 - 20:32',
                            style: TextStyle(
                              fontFamily: 'Lalezar',
                              fontSize: 18.0,
                              color: Constants.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
