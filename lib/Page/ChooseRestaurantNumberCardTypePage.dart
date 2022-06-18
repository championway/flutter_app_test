import 'package:flutter/material.dart';
import 'package:flutter_app_test/Util/Enum.dart';
import 'package:flutter_app_test/model/RestaurantNumberModel.dart';
import 'package:flutter_app_test/widget/RestaurantNumberWidget.dart';

class ChooseRestaurantNumberCardTypePage extends StatefulWidget {
  @override
  _ChooseRestaurantNumberCardTypePageState createState() =>
      _ChooseRestaurantNumberCardTypePageState();
}

class _ChooseRestaurantNumberCardTypePageState
    extends State<ChooseRestaurantNumberCardTypePage> {
  RESTAURANT_NUMBER_CARD_TYPE chooseCardType =
      RESTAURANT_NUMBER_CARD_TYPE.SINGLE;

  RestaurantNumberModel restaurantNumberModelSingle = RestaurantNumberModel(
      cardType: RESTAURANT_NUMBER_CARD_TYPE.SINGLE,
      inNumber: 8,
      outNumber: 24,
      phoneTime: DateTime.now(),
      updateTime: DateTime.now());
  RestaurantNumberModel restaurantNumberModelBoth = RestaurantNumberModel(
      cardType: RESTAURANT_NUMBER_CARD_TYPE.BOTH,
      inNumber: 8,
      outNumber: 24,
      phoneTime: DateTime.now(),
      updateTime: DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("新增貼文")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  chooseCardType = RESTAURANT_NUMBER_CARD_TYPE.SINGLE;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                      color:
                          chooseCardType == RESTAURANT_NUMBER_CARD_TYPE.SINGLE
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                      width: 2.5),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      child: Row(
                        children: [
                          Icon(chooseCardType ==
                                  RESTAURANT_NUMBER_CARD_TYPE.SINGLE
                              ? Icons.check_box_outlined
                              : Icons.check_box_outline_blank),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Single")
                        ],
                      ),
                    ),
                    RestaurantNumberWidget(restaurantNumberModelSingle),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  chooseCardType = RESTAURANT_NUMBER_CARD_TYPE.BOTH;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                      color: chooseCardType == RESTAURANT_NUMBER_CARD_TYPE.BOTH
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      width: 2.5),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      child: Row(
                        children: [
                          Icon(
                              chooseCardType == RESTAURANT_NUMBER_CARD_TYPE.BOTH
                                  ? Icons.check_box_outlined
                                  : Icons.check_box_outline_blank),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Single")
                        ],
                      ),
                    ),
                    RestaurantNumberWidget(restaurantNumberModelBoth),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
