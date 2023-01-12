import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/GoogleMapParsingPage.dart';
import 'package:flutter_app_test/Page/ChooseRestaurantNumberCardTypePage.dart';
import 'package:flutter_app_test/Page/CountdownTimerPage.dart';
import 'package:flutter_app_test/Page/CouponWidget.dart';
import 'package:flutter_app_test/Page/DateTimePickerPage.dart';
import 'package:flutter_app_test/Page/DeepLinkPage.dart';
import 'package:flutter_app_test/Page/MenuPage.dart';
import 'package:flutter_app_test/Page/OwnerRestaurantNumberPage.dart';
import 'package:flutter_app_test/Page/PointCardWidgetPage.dart';
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
  String _deepLink = "0";

  @override
  void initState() {
    super.initState();
  }

//  Future<void> _createDynamicLink(bool short) async {
//    setState(() {
//      _isCreatingLink = true;
//    });
//
//    final DynamicLinkParameters parameters = DynamicLinkParameters(
//      uriPrefix: 'https://flutterfiretests.page.link',
//      longDynamicLink: Uri.parse(
//        'https://flutterfiretests.page.link?efr=0&ibi=io.flutter.plugins.firebase.dynamiclinksexample&apn=io.flutter.plugins.firebase.dynamiclinksexample&imv=0&amv=0&link=https%3A%2F%2Fexample%2Fhelloworld&ofl=https://ofl-example.com',
//      ),
//      link: Uri.parse(DynamicLink),
//      androidParameters: const AndroidParameters(
//        packageName: 'io.flutter.plugins.firebase.dynamiclinksexample',
//        minimumVersion: 0,
//      ),
//      iosParameters: const IOSParameters(
//        bundleId: 'io.flutter.plugins.firebase.dynamiclinksexample',
//        minimumVersion: '0',
//      ),
//    );
//
//    Uri url;
//    if (short) {
//      final ShortDynamicLink shortLink =
//      await dynamicLinks.buildShortLink(parameters);
//      url = shortLink.shortUrl;
//    } else {
//      url = await dynamicLinks.buildLink(parameters);
//    }
//
//    setState(() {
//      _linkMessage = url.toString();
//      _isCreatingLink = false;
//    });
//  }

  @override
  void dispose() {
    super.dispose();
  } // Home page drawer widget

  Widget _drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          _listTile(Icons.api, "Basic API", () => {}),
          _listTile(Icons.report_outlined, "Report", () => {}),
          _listTile(
              Icons.restaurant, "Menu", () => {pushPage(context, MenuPage())}),
          _listTile(Icons.link, "Deep Link", () {
            pushPage(context, DeepLinkPage());
          }),
          _listTile(Icons.add_location, "Add Restaurant", () {
            pushPage(context, GoogleMapParsingPage());
          }),
          _listTile(Icons.money, "Coupon", () {
            pushPage(context, CouponWidget());
          }),
          _listTile(Icons.money, "PointCard", () {
            pushPage(context, PointCardWidgetPage());
          }),
          _listTile(Icons.qr_code_scanner, "QRScanner", () {
            pushPage(context, QRScanPage());
          }),
          _listTile(Icons.qr_code, "QRCode", () {
            pushPage(context, QRCodePage());
          }),
          _listTile(Icons.date_range, "Picker", () {
            pushPage(context, DateTimePickerPage());
          }),
          _listTile(Icons.post_add_outlined, "Choose", () {
            pushPage(context, ChooseRestaurantNumberCardTypePage());
          }),
          _listTile(Icons.confirmation_number, "Number", () {
            pushPage(context, RestaurantNumberPage());
          }),
          _listTile(Icons.confirmation_number_outlined, "Owner Number", () {
            pushPage(context, OwnerRestaurantNumberPage());
          }),
          _listTile(Icons.timer, "Countdown Time", () {
            pushPage(context, CountdownTimerPage());
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
    f = [2, 3];
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
            if (_scaffoldKey.currentState!.isDrawerOpen) {
              //if drawer is open, then close the drawer
              Navigator.pop(context);
            } else {
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
                Text(_deepLink),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
