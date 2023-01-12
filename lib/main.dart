import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/HomePage.dart';
import 'package:flutter_app_test/Util/Util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/l10n.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  PendingDynamicLinkData? _dynamicLinks;

  @override
  void initState(){
    initDynamicLinks();
    super.initState();
  }

  Future<void> initDynamicLinks() async {
    dynamicLinks.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLinks) async {
          setState(() {
            _dynamicLinks = dynamicLinks;
          });
          print("onSuccess");
          showToast("DeepLink1");
          showToast(dynamicLinks!.link.toString());
          showToast(dynamicLinks.link.path.toString());
          showToast(dynamicLinks.link.queryParameters.values.toString());
          showToast(dynamicLinks.link.queryParameters.values.first.toString());
          print(dynamicLinks.link.queryParameters.values.toString());
          showToast("onSuccess");
          final Uri? deepLink = dynamicLinks.link;

          if (deepLink != null) {
            handleDeepLink(deepLink);
          }
        }, onError: (OnLinkErrorException e) async {
      print("onError");
      showToast(e.toString());
    });
//    dynamicLinks.onLink.listen((dynamicLinkData) {
//      final Uri? deepLink = dynamicLinkData.link;
//      if (deepLink != null){
//        handleDeepLink(deepLink);
//      }
//
//      Navigator.pushNamed(context, dynamicLinkData.link.path);
//    }).onError((error) {
//      print('onLink error');
//      print(error.message);
//    });
  }

  void handleDeepLink(Uri uri) {
    print(uri);
    showToast(uri.toString());
  }

  @override
  Widget build(BuildContext context) {
    if (_dynamicLinks!=null) {
      print(_dynamicLinks!.link);
      print(_dynamicLinks!.link.path);
      print(_dynamicLinks!.link.queryParameters.values);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      supportedLocales: L10n.all,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      home: HomePage(),
    );
  }
}