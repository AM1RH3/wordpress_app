import 'package:flutter/material.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/ui/utils/custom_add_quantity.dart';
import 'package:woedpress_app/ui/utils/extensions.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 8,
            child: Container(
              padding:
                  const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Constants.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 80.0,
                    width: size.width,
                    margin: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                    padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                height: 20.0,
                                child: Image.asset(
                                    'assets/images/PriceUnit-green.png')),
                            const SizedBox(width: 5.0),
                            Text(
                              '22,000'.farsiNumber,
                              style: TextStyle(
                                fontFamily: 'Lalezar',
                                color: Constants.primaryColor,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 5.0, right: 5.0),
                              child: Container(
                                width: 60.0,
                                height: 60.0,
                                decoration: BoxDecoration(
                                  color:
                                      Constants.primaryColor.withOpacity(0.8),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            const Positioned(
                              bottom: 5.0,
                              left: 0,
                              right: 0,
                              child: SizedBox(
                                height: 80.0,
                                child: Text(''),
                              ),
                            ),
                            Positioned(
                              right: 70.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Row(
                                    children: [
                                      Text(
                                        'نام محصول',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          fontFamily: 'Lalezar',
                                        ),
                                      ),
                                      SizedBox(width: 19.0),
                                    ],
                                  ),
                                  CustomQuantity(
                                    minNumber: 0,
                                    maxNumber: 20,
                                    iconSize: 15.0,
                                    value: 1,
                                    onChanged: (value) {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          Flexible(
            flex: 1,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Divider(thickness: 0.5),
                          const Text(
                            'جمع کل',
                            style: TextStyle(
                              fontFamily: 'Lalezar',
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 15.0,
                                    child: Image.asset(
                                        'assets/images/PriceUnit-green.png'),
                                  ),
                                  const SizedBox(width: 5.0),
                                  Text(
                                    '50.000'.farsiNumber,
                                    style: TextStyle(
                                      fontFamily: 'Lalezar',
                                      color: Constants.primaryColor,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.sync)),
                      InkResponse(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            color: Constants.primaryColor,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0.0, 1.1),
                                blurRadius: 5.0,
                                color: Constants.primaryColor.withOpacity(0.3),
                              ),
                            ],
                          ),
                          child: InkResponse(
                            onTap: () {},
                            child: const Text(
                              'مرحله بعد',
                              style: TextStyle(
                                fontFamily: 'Lalezar',
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
