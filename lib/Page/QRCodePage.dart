import 'dart:io';
import 'dart:typed_data';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_test/Util/Util.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'dart:convert';
import 'dart:ui' as ui;

class QRCodePage extends StatefulWidget {
  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  GlobalKey _globalKey = new GlobalKey();

  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    textEditingController.text = "e1857189-21e6-4743-b458-45b3db121236";
    super.initState();
  }

  Future<void> _capturePng() async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();

    Directory directory = await new Directory(appDocDirectory.path).create(recursive: true);

    RenderRepaintBoundary boundary =
    _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    print(pngBytes);
    String imgPath = directory.path + '/' + 'qr_code_flutter.jpg';
    print(imgPath);
//    await File(imgPath).writeAsBytes(pngBytes);
////    final result = await ImageGallerySaver.saveFile(imgPath);
////    print(result.toString());
//    final result1 = await ImageGallerySaver.saveImage(pngBytes, name: "Hello");
//    print(result1.toString());
    print("Done");
  }

  @override
  Widget build(BuildContext context) {
    String restaurantID = "e1857189-21e6-4743-b458-45b3db121236";
    String point = "2";
    String mode = "1";
    textEditingController.text = restaurantID + "." + point + "." + mode;
    return Scaffold(
      appBar: AppBar(
        title: Text("Barcode Scanner"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RepaintBoundary(
                key: _globalKey,
                child: GestureDetector(
                  onLongPress: () {
                    _capturePng();
                    showToast("Save Image");
                  },
                  child: QrImage(
                    data: textEditingController.text,
                    size: 200,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 40),
              buildTextField(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: "Enter the data",
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Theme.of(context).accentColor)),
          suffixIcon: IconButton(
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.done, size: 30),
            onPressed: () => setState(() {}),
          )),
    );
  }
}
