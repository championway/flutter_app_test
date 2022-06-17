import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/Util/Enum.dart';
import 'package:flutter_app_test/Util/Util.dart';
import 'package:flutter_app_test/model/RestaurantNumberModel.dart';

//https://www.youtube.com/watch?v=QBwLJKbCIlo&ab_channel=MadewithFlutter

class OwnerRestaurantNumberPage extends StatefulWidget {
  @override
  _OwnerRestaurantNumberPageState createState() =>
      _OwnerRestaurantNumberPageState();
}

class _OwnerRestaurantNumberPageState extends State<OwnerRestaurantNumberPage> {
  RESTAURANT_NUMBER_TYPE _chooseType = RESTAURANT_NUMBER_TYPE.IN;
  RESTAURANT_NUMBER_CARD_TYPE _cardType = RESTAURANT_NUMBER_CARD_TYPE.BOTH;

  String numberPadValue = "";

  RestaurantNumberModel restaurantNumberModel = RestaurantNumberModel(
      cardType: RESTAURANT_NUMBER_CARD_TYPE.BOTH, inNumber: 24, outNumber: 53);

  @override
  void initState() {
    numberPadValue = restaurantNumberModel.inNumber.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("候位號碼牌系統"),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
        ),
        body: userInputArea());
  }

  Widget userInputArea() {
    return Column(
      children: [
        Visibility(
          visible: _cardType == RESTAURANT_NUMBER_CARD_TYPE.BOTH,
          child: Row(
            children: [
              chooseTypeCard(restaurantNumberModel, RESTAURANT_NUMBER_TYPE.IN),
              chooseTypeCard(restaurantNumberModel, RESTAURANT_NUMBER_TYPE.OUT)
            ],
          ),
        ),
        SizedBox(
          height: 6,
        ),
        numberCard(restaurantNumberModel, _chooseType),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              numberPadValue,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(flex: 3, child: numberPad()),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    buildAction(type: 0),
                    buildAction(type: 1),
                    buildAction(type: 2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget chooseTypeCard(RestaurantNumberModel restaurantNumberModel,
      RESTAURANT_NUMBER_TYPE restaurantNumberType) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Card(
          color: _chooseType == restaurantNumberType
              ? Colors.yellow[300]
              : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onTap: () {
                setState(() {
                  _chooseType = restaurantNumberType;
                  numberPadValue =
                      restaurantNumberType == RESTAURANT_NUMBER_TYPE.IN
                          ? restaurantNumberModel.inNumber.toString()
                          : restaurantNumberModel.outNumber.toString();
                });
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    Text(restaurantNumberType == RESTAURANT_NUMBER_TYPE.IN
                        ? "內用"
                        : "外帶"),
                    SizedBox(
                      height: 5,
                    ),
                    Text(restaurantNumberType == RESTAURANT_NUMBER_TYPE.IN
                        ? restaurantNumberModel.inNumber.toString()
                        : restaurantNumberModel.outNumber.toString())
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget numberCard(RestaurantNumberModel restaurantNumberModel,
      RESTAURANT_NUMBER_TYPE restaurantNumberType) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
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
                          "餐廳更新時間 6/13 13:01:46",
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "手機更新時間 6/13 13:01:46",
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
                    _cardType == RESTAURANT_NUMBER_CARD_TYPE.SINGLE
                        ? SizedBox.shrink()
                        : Expanded(
                            child: Center(
                              child: Text(
                                restaurantNumberType ==
                                        RESTAURANT_NUMBER_TYPE.IN
                                    ? "內用"
                                    : "外帶",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                    Expanded(
                      child: Center(
                        child: Text(
                          restaurantNumberType == RESTAURANT_NUMBER_TYPE.IN
                              ? restaurantNumberModel.inNumber.toString()
                              : restaurantNumberModel.outNumber.toString(),
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.w600),
                        ),
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

  Widget numberPad() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.09,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildNumber(number: 1),
                buildNumber(number: 2),
                buildNumber(number: 3),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.09,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildNumber(number: 4),
                buildNumber(number: 5),
                buildNumber(number: 6),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.09,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildNumber(number: 7),
                buildNumber(number: 8),
                buildNumber(number: 9),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.09,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildNumber(type: 2),
                buildNumber(number: 0),
                buildNumber(type: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int stringValueToInt(str) {
    int valueInt;
    if (str == "") {
      valueInt = 0;
    } else {
      valueInt = int.parse(str);
    }
    return valueInt;
  }

  onNumberSelected(value) {
    setState(() {
      if (value >= 0) {
        // press number
        int numberPadValueInt = stringValueToInt(numberPadValue);
        if (numberPadValueInt == 0) {
          // we don't want first digit to ba '0'
          numberPadValue = value.toString();
        } else if (numberPadValue.length + 1 <= 4) {
          // if value small than 4 digits, then add the number
          numberPadValue = numberPadValue + value.toString();
        }
      } else if (value == -1) {
        // press backspace
        numberPadValue = numberPadValue.substring(0, numberPadValue.length - 1);
      } else if (value == -2) {
        // press clear
        numberPadValue = "0";
      }
    });
  }

  onActionSelected(value) {
    setState(() {
      int numberPadValueInt = stringValueToInt(numberPadValue);
      if (value == 1) {
        // press +1
        if (numberPadValueInt < 9999) {
          numberPadValue = (numberPadValueInt + 1).toString();
        }
      } else if (value == -1) {
        // press -1
        if (numberPadValueInt > 0) {
          numberPadValue = (numberPadValueInt - 1).toString();
        }
      } else if (value == 0) {
        // press send
        if (_chooseType == RESTAURANT_NUMBER_TYPE.IN) {
          restaurantNumberModel.inNumber = stringValueToInt(numberPadValue);
        } else {
          restaurantNumberModel.outNumber = stringValueToInt(numberPadValue);
        }
        showToast("Send");
      }
    });
  }

  Widget buildNumber({int? number, int type: 0}) {
    // type = 0 : number, type = 1 : backspace, type = 2 : clear
    Widget content = Container();
    late Function onTapFunc;
    if (type == 0) {
      content = Text(
        number!.toString(),
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      );
      onTapFunc = () {
        onNumberSelected(number);
      };
    } else if (type == 1) {
      content = Icon(
        Icons.backspace,
        size: 28,
      );
      onTapFunc = () {
        onNumberSelected(-1);
      };
    } else if (type == 2) {
      content = Icon(
        Icons.clear,
        size: 28,
      );
      onTapFunc = () {
        onNumberSelected(-2);
      };
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          onTap: () {
            onTapFunc();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Center(
              child: content,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAction({int type: 0}) {
    // type = 0 : number, type = 1 : backspace, type = 2 : clear
    Widget content = Container();
    late Function onTapFunc;
    if (type == 0) {
      content = Text(
        "+1",
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      );
      onTapFunc = () {
        onActionSelected(1);
      };
    } else if (type == 1) {
      content = Text(
        "-1",
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      );
      onTapFunc = () {
        onActionSelected(-1);
      };
    } else if (type == 2) {
      content = Icon(
        Icons.send,
        size: 28,
      );
      onTapFunc = () {
        onActionSelected(0);
      };
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          onTap: () {
            onTapFunc();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Center(
              child: content,
            ),
          ),
        ),
      ),
    );
  }
}
