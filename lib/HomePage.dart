import 'package:flutter/material.dart';
import 'package:flutter_app_test/GoogleMapParsingPage.dart';
import 'package:flutter_app_test/Page/AddPostPage.dart';
import 'package:flutter_app_test/Page/BusinessTimePicker.dart';
import 'package:flutter_app_test/Page/CouponWidget.dart';
import 'package:flutter_app_test/Page/DateTimePickerPage.dart';
import 'package:flutter_app_test/Page/QRCodePage.dart';
import 'package:flutter_app_test/Page/QRScanPage.dart';
import 'package:flutter_app_test/Page/RestaurantNumberPage.dart';
import 'package:flutter_app_test/Util/Util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  } // Home page drawer widget

  Widget _drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          _listTile(Icons.api, "Basic API", () => {
          }),
          _listTile(Icons.report_outlined, "Report", () => {}),
          _listTile(Icons.restaurant, "Restaurant", () => {}),
          _listTile(Icons.search, "null", () {}),
          _listTile(Icons.add_location, "Add Restaurant", () {
            pushPage(context, GoogleMapParsingPage());
          }),
          _listTile(Icons.money, "Coupon", () {pushPage(context, CouponWidget());}),
          _listTile(Icons.qr_code_scanner, "QRScanner", () {pushPage(context, QRScanPage());}),
          _listTile(Icons.qr_code, "QRCode", () {pushPage(context, QRCodePage());}),
          _listTile(Icons.date_range, "Picker", () {pushPage(context, DateTimePickerPage());}),
          _listTile(Icons.post_add_outlined, "null", () {
            pushPage(context, AddPostPage());
          }),
          _listTile(Icons.confirmation_number, "Number", () {
            pushPage(context, RestaurantNumberPage());
          }),
        ],
      ),
    );
  }

  // List tile for drawer list
  Widget _listTile(icon, text, onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))),
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    String? a;
    var f;
    f  = [2, 3];
    print(f.length);
//    a = "ddd";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
//        automaticallyImplyLeading: false,
        title: Text(
          "InFood",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        iconTheme: IconThemeData(color: Colors.blue),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            if(_scaffoldKey.currentState!.isDrawerOpen){
              //if drawer is open, then close the drawer
              Navigator.pop(context);
            }else{
              _scaffoldKey.currentState!.openDrawer();
              //if drawer is closed then open the drawer.
            }
          },
        ),
      ),
      body: Scaffold(
        key: _scaffoldKey,
        drawer: _drawer(context),
        body: Center(
          child: Container(
            child: Column(
              children: [
                Text("InFood"),
                Text(AppLocalizations.of(context)!.language),
                Text(AppLocalizations.of(context)!.hello),
                Text(AppLocalizations.of(context)!.nice),
                Text(AppLocalizations.of(context)!.nice),
              ],
            ),
          ),
        ),
      ),
    );
  }
}