import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/Util/Util.dart';

class PointCardWidgetPage extends StatefulWidget {
  @override
  _PointCardWidgetPageState createState() => _PointCardWidgetPageState();
}

class _PointCardWidgetPageState extends State<PointCardWidgetPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    _tabController.addListener(() {
      setState(() {
        _tabIndex = _tabController.index;
      });
    });
  }

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

  Widget testCard() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        child: SizedBox(
          height: 50,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.blue),
            child: Center(
              child: Text("T"),
            ),
          ),
        ),
      ),
    );
  }

  Widget pointSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "點數: ${5}",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: (){
                showToast("詳細資訊");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
                child: Container(
                  child: Row(
                    children: [
                      Text("詳細資訊", style: TextStyle(fontSize: 13),),
                      SizedBox(width: 5,),
                      Icon(Icons.arrow_forward_ios, size: 15,)
                    ],
                  ),
                ),
              ),
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
              controller: _tabController,
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
                  controller: _tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      child: Center(
                        child: Text("1"),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          testCard(),
                          testCard(),
                          testCard(),
                          testCard(),
                          testCard(),
                          testCard(),
                          testCard(),
                          testCard(),
                          testCard(),
                          testCard(),
                          testCard(),
                          testCard(),
                        ],
                      ),
                    )
                  ]),
            ),
            Visibility(
                visible: _tabIndex == 0,
                child: pointSection()),
          ],
        ),
      ),
    );
  }
}
