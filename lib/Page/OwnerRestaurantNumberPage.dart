import 'package:flutter/material.dart';
import 'package:flutter_app_test/Util/Util.dart';

//https://www.youtube.com/watch?v=QBwLJKbCIlo&ab_channel=MadewithFlutter

class OwnerRestaurantNumberPage extends StatefulWidget {
  @override
  _OwnerRestaurantNumberPageState createState() =>
      _OwnerRestaurantNumberPageState();
}

class _OwnerRestaurantNumberPageState extends State<OwnerRestaurantNumberPage> {
//  final Function(int) onNumberSelected;
//
//  NumericPad({@required this.onNumberSelected});
  String numberPadValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("候位號碼牌系統"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  numberPadValue,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Expanded(flex: 6, child: numberPad()),
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
            height: MediaQuery.of(context).size.height * 0.11,
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
            height: MediaQuery.of(context).size.height * 0.11,
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
            height: MediaQuery.of(context).size.height * 0.11,
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
            height: MediaQuery.of(context).size.height * 0.11,
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

  onNumberSelected(value) {
    setState(() {
      if (value >= 0) {
        if (numberPadValue.length + 1 <= 4) {
          numberPadValue = numberPadValue + value.toString();
        }
      } else if (value == -1) {
        numberPadValue = numberPadValue.substring(0, numberPadValue.length - 1);
      } else if (value == -2) {
        numberPadValue = "";
      }
    });
  }

  onActionSelected(value) {
    setState(() {
      int numberPadValueInt;
      if (numberPadValue == "") {
        numberPadValueInt = 0;
      } else {
        numberPadValueInt = int.parse(numberPadValue);
      }
      if (value == 1) {
        if (numberPadValueInt < 9999) {
          numberPadValue = (numberPadValueInt + 1).toString();
        }
      } else if (value == -1) {
        if (numberPadValueInt > 0) {
          numberPadValue = (numberPadValueInt - 1).toString();
        }
      } else if (value == 0) {
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
