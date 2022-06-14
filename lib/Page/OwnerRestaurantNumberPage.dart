import 'package:flutter/material.dart';

class OwnerRestaurantNumberPage extends StatefulWidget {
  @override
  _OwnerRestaurantNumberPageState createState() =>
      _OwnerRestaurantNumberPageState();
}

class _OwnerRestaurantNumberPageState extends State<OwnerRestaurantNumberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("候位號碼牌系統"),
      ),
      body: numberPad(),
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

  Widget buildNumber({int? number, int type : 0}) {
    // type = 0 : number, type = 1 : backspace, type = 2 : clear
    Widget content = Container();
    if (type == 0){
      content = Text(
        number!.toString(),
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    else if (type == 1){
      content = Icon(Icons.backspace, size: 28,);
    }
    else if (type == 2){
      content = Icon(Icons.clear, size: 28,);
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
    );
  }
}
