import 'package:flutter_app_test/Util/Enum.dart';

class RestaurantNumberModel {
  RestaurantNumberModel(
      {this.cardType: RESTAURANT_NUMBER_CARD_TYPE.BOTH,
      this.inNumber: 0,
      this.outNumber: 0,
      this.phoneTime,
      this.updateTime,
      this.createTime});

  RESTAURANT_NUMBER_CARD_TYPE cardType;
  int inNumber;
  int outNumber;
  DateTime? phoneTime;
  DateTime? updateTime;
  DateTime? createTime;
}
