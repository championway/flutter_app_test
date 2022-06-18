import 'package:flutter/material.dart';
import 'package:flutter_app_test/Util/Enum.dart';
import 'package:flutter_app_test/model/RestaurantNumberModel.dart';
import 'package:flutter_app_test/widget/RestaurantNumberWidget.dart';

class RestaurantNumberPage extends StatefulWidget {
  @override
  _RestaurantNumberPageState createState() => _RestaurantNumberPageState();
}

class _RestaurantNumberPageState extends State<RestaurantNumberPage> {
//  RESTAURANT_NUMBER_CARD_TYPE cardType = RESTAURANT_NUMBER_CARD_TYPE.SINGLE;

  RestaurantNumberModel restaurantNumberModel = RestaurantNumberModel(
      cardType: RESTAURANT_NUMBER_CARD_TYPE.BOTH,
      inNumber: 24,
      outNumber: 53,
      phoneTime: DateTime.now(),
      updateTime: DateTime.now());

  @override
  void initState() {
    // TODO: implement initState
    restaurantNumberModel.phoneTime = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("餐廳候位號碼牌"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  restaurantNumberModel.phoneTime = DateTime.now();
                });
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: RestaurantNumberWidget(restaurantNumberModel),
      ),
    );
  }
}
