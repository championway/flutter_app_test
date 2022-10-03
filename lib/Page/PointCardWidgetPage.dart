import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/Util/Util.dart';

class PointCardWidgetPage extends StatelessWidget {
  Widget pointCardWidget() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          showToast("集點卡");
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Restaurant Name",
                    style: TextStyle(fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: IconButton(
                      onPressed: () {
                        showToast("Setting");
                      },
                      iconSize: 18,
                      icon: Icon(Icons.more_horiz_outlined),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text("點數: "),
                  Text(
                    "15點",
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pointSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 15.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "點數: ${5}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("集點卡"),
        ),
        body: Column(
          children: [
            pointSection(),
            TabBar(
              tabs: [
                Tab(
                  child: Text(
                    "優惠券",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                Tab(
                  child: Text(
                    "點數紀錄",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      child: Center(
                        child: Text("1"),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text("2"),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
