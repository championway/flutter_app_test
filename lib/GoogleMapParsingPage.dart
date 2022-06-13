import 'package:flutter/material.dart';
import 'package:flutter_app_test/Util/Util.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class GoogleMapParsingPage extends StatefulWidget {
  @override
  _GoogleMapParsingPageState createState() => _GoogleMapParsingPageState();
}


class _GoogleMapParsingPageState extends State<GoogleMapParsingPage> {
  final TextEditingController textEditingController = new TextEditingController();
  String result = "Null";
  String name = "";
  String phone = "";
  String address = "";
  String website = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Restaurant"),),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(hintText: 'Google map link'),
                ),
                ElevatedButton(
                  child: Text("Get Data"),
                  onPressed: () async{
                    result = await getGoogleUrl(textEditingController.text);
                    setState(() {});
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Name: $name"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Address: $address"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Phone: $phone"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Website: $website"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getGoogleUrl(String url) async {
    try {
      final response = await http.get(
          Uri.parse('https://' + url.split('https://').last), headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        var document = parse(response.body);
        phone = response.body.split('tel:').last.split('\\')[0];
        var nameAddress = response.body.split('" itemprop="name"')[0].split('meta content="').last;
        name = nameAddress.split(' · ')[0];
        address = nameAddress.split(' · ').last;
        website = response.body.split('/url?q\\\\u003d').last.split('\\\\')[0];
        print(phone);
        print(name);
        print(address);
        print(website);
        return response.body;
      }
      showToast(response.statusCode.toString());
      return response.statusCode.toString();
    } catch (e) {
      print(e);
      showToast(e.toString());
      return e.toString();
    }
  }
}