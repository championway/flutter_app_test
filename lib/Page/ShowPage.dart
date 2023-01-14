import 'package:flutter/material.dart';

class ShowPage extends StatefulWidget {
  ShowPage({this.showText: "showText"});

  final String showText;

  @override
  _ShowPageState createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  late String showText;

  @override
  void initState() {
    showText = widget.showText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text("SHOW PAGE")),
      body: Center(
        child: Container(
          child: Text(showText),
        ),
      ),
    );
  }
}
