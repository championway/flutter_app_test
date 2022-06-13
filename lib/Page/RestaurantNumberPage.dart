import 'package:flutter/material.dart';

class RestaurantNumberPage extends StatefulWidget {
  @override
  _RestaurantNumberPageState createState() => _RestaurantNumberPageState();
}

class _RestaurantNumberPageState extends State<RestaurantNumberPage> {
  String? currentTime;
  bool showBoth = false;

  getCurrentTimeString() {
    DateTime now = DateTime.now();
    String str = now.month.toString() +
        "/" +
        now.day.toString() +
        " " +
        now.hour.toString() +
        ":" +
        now.minute.toString() +
        ":" +
        now.second.toString();
    setState(() {
      currentTime = str;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentTimeString();
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
                getCurrentTimeString();
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Card(
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
                              "餐廳更新時間 6/13 13:01:46",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "手機更新時間 $currentTime",
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
                        Expanded(
                          child: Center(
                            child: Text(
                              "內用",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "32",
                              style: TextStyle(
                                  fontSize: 35, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: showBoth,
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
                                    "64",
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
        ),
      ),
    );
  }
}
