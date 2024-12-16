import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woedpress_app/constants/constants.dart';
import 'package:woedpress_app/providers/shop_provider.dart';
import 'package:woedpress_app/ui/utils/custom_add_quantity.dart';

class BuildCartItems extends StatelessWidget {
  final Size size;
  const BuildCartItems({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopProvider>(
      builder: (context, cartModel, child) {
        return Flexible(
          flex: 8,
          child: Container(
            padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: cartModel.itemsinCart!.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Constants.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: 90.0,
                  width: size.width,
                  margin: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    top: 10.0,
                    right: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 20.0,
                            child: Image.asset(
                              'assets/images/PriceUnit-green.png',
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            Constants.numberFormat.format(
                              int.parse(
                                cartModel
                                    .itemsinCart![index].productRegularPrice
                                    .toString(),
                              ),
                            ),
                            style: TextStyle(
                              fontFamily: 'Lalezar',
                              color: Constants.primaryColor,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Text(
                                cartModel.itemsinCart![index].productName
                                    .toString(),
                                style: const TextStyle(
                                  fontSize: 13.0,
                                  fontFamily: 'Lalezar',
                                ),
                              ),
                              const SizedBox(width: 19.0),
                            ],
                          ),
                          CustomQuantity(
                            minNumber: 0,
                            maxNumber: 20,
                            iconSize: 15.0,
                            value:
                                cartModel.itemsinCart![index].quantity!.toInt(),
                            onChanged: (value) {
                              if (cartModel.itemsinCart![index].quantity! > 0) {
                                Provider.of<ShopProvider>(context,
                                        listen: false)
                                    .updateQty(
                                  cartModel.itemsinCart![index].productId!,
                                  value,
                                );
                              } else {
                                Provider.of<ShopProvider>(context,
                                        listen: false)
                                    .removeItem(
                                  cartModel.itemsinCart![index].productId!,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 5.0, right: 5.0),
                            child: Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Constants.primaryColor.withOpacity(0.8),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 5.0,
                            left: 0,
                            right: 0,
                            child: SizedBox(
                              height: 60.0,
                              child: Image.network(
                                cartModel.itemsinCart![index].thumbnail
                                    .toString(),
                                fit: BoxFit.contain,
                              ),
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
        );
      },
    );
  }
}
