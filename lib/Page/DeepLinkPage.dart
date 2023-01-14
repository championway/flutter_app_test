import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeepLinkPage extends StatefulWidget {
  @override
  _DeepLinkPageState createState() => _DeepLinkPageState();
}

class _DeepLinkPageState extends State<DeepLinkPage> {

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  String _linkMessage = '';


  Future<void> _createDynamicLink(bool short) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://infood.page.link',
      link: Uri.parse('https://infood.page.link?abc=efg&123=456'),
      androidParameters: AndroidParameters(
        packageName: 'com.infood.infood',
        minimumVersion: 0,
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink = await parameters.buildShortLink();
      url = shortLink.shortUrl;
    } else {
      url = await parameters.buildUrl();
    }

    setState(() {
      _linkMessage = url.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DEEP LINK"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonBar(
              children: [
                ElevatedButton(onPressed: (){
                  _createDynamicLink(false);
                }, child: Text("Get Long Link")),
                ElevatedButton(onPressed: (){
                  _createDynamicLink(true);
                }, child: Text("Get Short Link")),
              ],
            ),
            InkWell(
              onTap: (){},
              onLongPress: (){
                Clipboard.setData(ClipboardData(text: _linkMessage));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Copied Link!")));
              },
              child: Text(_linkMessage),
            )
          ],
        ),
      ),
    );
  }
}
