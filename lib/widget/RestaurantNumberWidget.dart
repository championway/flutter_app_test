import 'package:flutter/material.dart';
import 'package:flutter_app_test/Util/Enum.dart';
import 'package:flutter_app_test/Util/Util.dart';
import 'package:flutter_app_test/model/RestaurantNumberModel.dart';

class RestaurantNumberWidget extends StatelessWidget {
  RestaurantNumberWidget(this.restaurantNumberModel);

  final RestaurantNumberModel restaurantNumberModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "餐廳更新時間 ${dateTimeToString(restaurantNumberModel.updateTime!)}",
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "手機更新時間 ${dateTimeToString(restaurantNumberModel.phoneTime!)}",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Text("當前號碼", style: TextStyle(fontSize: 14))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    restaurantNumberModel.cardType == RESTAURANT_NUMBER_CARD_TYPE.BOTH
                        ? Expanded(
                      child: Center(
                        child: Text(
                          "內用",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                        : SizedBox.shrink(),
                    Expanded(
                      child: Center(
                        child: Text(
                          restaurantNumberModel.inNumber.toString(),
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: restaurantNumberModel.cardType == RESTAURANT_NUMBER_CARD_TYPE.BOTH,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                "外帶",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                restaurantNumberModel.outNumber.toString(),
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w600),
                              ),
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
      ),
    );
  }
}
