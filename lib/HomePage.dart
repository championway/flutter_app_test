import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/GoogleMapParsingPage.dart';
import 'package:flutter_app_test/Page/ChooseRestaurantNumberCardTypePage.dart';
import 'package:flutter_app_test/Page/CountdownTimerPage.dart';
import 'package:flutter_app_test/Page/CouponWidget.dart';
import 'package:flutter_app_test/Page/DateTimePickerPage.dart';
import 'package:flutter_app_test/Page/DeepLinkPage.dart';
import 'package:flutter_app_test/Page/ImagePickerPage.dart';
import 'package:flutter_app_test/Page/MenuPage.dart';
import 'package:flutter_app_test/Page/OwnerRestaurantNumberPage.dart';
import 'package:flutter_app_test/Page/PhotoEditorPage.dart';
import 'package:flutter_app_test/Page/PointCardWidgetPage.dart';
import 'package:flutter_app_test/Page/QRCodePage.dart';
import 'package:flutter_app_test/Page/QRScanPage.dart';
import 'package:flutter_app_test/Page/RestaurantNumberPage.dart';
import 'package:flutter_app_test/Page/ShowPage.dart';
import 'package:flutter_app_test/Util/Util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _deepLink = "0";
  PendingDynamicLinkData? _dynamicLinks;

  @override
  void initState() {
    this.initDynamicLinks(context);
    super.initState();
  }


  initDynamicLinks(BuildContext context) async {
    print("Homepage: get deep link");
//    await Future.delayed(Duration(seconds: 1));
    var data = await FirebaseDynamicLinks.instance.getInitialLink();
    Uri? deepLink = data?.link;
    if (deepLink != null) {
      final queryParams = deepLink.queryParameters;
      showToast("Homepage init");
      if (queryParams.length > 0) {
        String data = queryParams["id"]??"null data";
        pushPage(context, ShowPage(showText: "Init: " + data,));
      }
    }
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLinks) async {
          setState(() {
            _dynamicLinks = dynamicLinks;
          });
          print("Homepage: onSuccess");
          showToast("Homepage: DeepLink");
          showToast(dynamicLinks!.link.toString());
          final Uri? deepLink = dynamicLinks.link;

          if (deepLink != null) {
            handleDeepLink(deepLink);
          }
        }, onError: (OnLinkErrorException e) async {
      print("Homepage: onError");
      showToast(e.toString());
    });
  }

  void handleDeepLink(Uri uri) {
    print(uri);
    showToast(uri.toString());
    String data = uri.queryParameters["id"]??"null data";
    pushPage(context, ShowPage(showText: "handle: " + data,));
  }

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
          _listTile(Icons.text_fields, "Show Page", () {
            pushPage(context, ShowPage());
          }),
          _listTile(Icons.text_fields, "Image Picker Page", () {
            pushPage(context, ImagePickerPage());
          }),
          _listTile(Icons.photo, "Photo Editor", () {
            pushPage(context, PhotoEditorPage());
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
    if (_dynamicLinks!=null) {
      print("==== Homepage ===");
      print(_dynamicLinks!.link); // https://fluttercpw.page.link?type=ABC&id=asdf
      print(_dynamicLinks!.link.path); // type=ABC&id=asdf
      print(_dynamicLinks!.link.query); // {type: ABC, id: asdf}
      print(_dynamicLinks!.link.queryParameters); // (ABC, asdf)
      print(_dynamicLinks!.link.queryParameters.values); // null
      print("*******");
    }
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
