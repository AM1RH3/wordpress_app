import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/providers/order_provider.dart';
import 'package:woedpress_app/ui/utils/extensions.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      OrderProvider orderProvider = Provider.of(context, listen: false);
      orderProvider.fetchOrders();
    });
    super.initState();
  }

  Widget buildTextIcon(
    Icon iconWidget,
    Text textWidget,
  ) {
    return Row(
      children: [
        const SizedBox(width: 3.0),
        iconWidget,
        const SizedBox(width: 10.0),
        textWidget,
      ],
    );
  }

  Widget orderStatus(String status) {
    Icon icon;
    Color color;

    if (status == 'pending' || status == 'processing' || status == 'on-hold') {
      icon = const Icon(Icons.timer, color: Color.fromARGB(255, 222, 156, 57));
      color = const Color.fromARGB(255, 196, 121, 8);
    } else if (status == 'completed') {
      icon = const Icon(Icons.check, color: Color.fromARGB(255, 73, 164, 74));
      color = const Color.fromARGB(255, 70, 121, 71);
    } else if (status == 'cancelled' ||
        status == 'refunded' ||
        status == 'failed') {
      icon = const Icon(Icons.clear, color: Color.fromARGB(255, 163, 63, 63));
      color = const Color.fromARGB(255, 141, 26, 26);
    } else {
      icon = const Icon(Icons.clear, color: Color.fromARGB(255, 163, 63, 63));
      color = const Color.fromARGB(255, 141, 26, 26);
    }

    return buildTextIcon(
      icon,
      status == 'pending'
          ? Text(
              'سفارش در انتظار بررسی',
              style: TextStyle(
                color: color,
                fontFamily: 'Lalezar',
                fontSize: 16,
              ),
            )
          : status == 'processing'
              ? Text(
                  'سفارش درحال انجام',
                  style: TextStyle(
                    color: color,
                    fontFamily: 'Lalezar',
                    fontSize: 16,
                  ),
                )
              : status == 'on-hold'
                  ? Text(
                      'سفارش در انتظار پرداخت',
                      style: TextStyle(
                        color: color,
                        fontFamily: 'Lalezar',
                        fontSize: 16,
                      ),
                    )
                  : status == 'completed'
                      ? Text(
                          'سفارش تکمیل شده',
                          style: TextStyle(
                            color: color,
                            fontFamily: 'Lalezar',
                            fontSize: 16,
                          ),
                        )
                      : status == 'cancelled'
                          ? Text(
                              'سفارش لغو شده',
                              style: TextStyle(
                                color: color,
                                fontFamily: 'Lalezar',
                                fontSize: 16,
                              ),
                            )
                          : Text(
                              'کنسل',
                              style: TextStyle(
                                color: color,
                                fontFamily: 'Lalezar',
                                fontSize: 16,
                              ),
                            ),
    );
  }

  String toStringJalali(Jalali? d) {
    final f = d!.formatter;
    return '${d.minute} : ${d.hour}   - -   ${f.y}/${f.m}/${f.d}'.farsiNumber;
  }

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
        body: Consumer<OrderProvider>(
          builder: (context, orderModel, child) {
            if (orderModel.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (orderModel.allorders != null &&
                orderModel.allorders!.isNotEmpty) {
              return ListView.builder(
                itemCount: orderModel.allorders!.length,
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
                              orderStatus(orderModel.allorders![index].status
                                  .toString()),
                              const Divider(color: Colors.black),
                              const SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      buildTextIcon(
                                        const Icon(Icons.info_outline_rounded),
                                        const Text(
                                          'شماره سفارش  :',
                                          style: TextStyle(
                                            fontFamily: 'Lalezar',
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    orderModel.allorders![index].orderId
                                        .toString()
                                        .farsiNumber,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      buildTextIcon(
                                        const Icon(Icons.timelapse_outlined),
                                        const Text(
                                          'تاریـخ سفـارش  :',
                                          style: TextStyle(
                                            fontFamily: 'Lalezar',
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    toStringJalali(orderModel
                                            .allorders![index].orderDate)
                                        .toString(),
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
              );
            } else {
              return const Center(
                child: Text('هیچ سفارشی ثبت نشده '),
              );
            }
          },
        ));
  }
}

//0
