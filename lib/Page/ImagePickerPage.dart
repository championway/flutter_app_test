
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_test/Util/Util.dart';
import 'package:flutter_storage_path/flutter_storage_path.dart';
// ignore: import_of_legacy_library_into_null_safe
//import 'package:storage_path/storage_path.dart';

class FileModel {
  List<String> files = [];
  String folder = "";

  FileModel({required this.files, required this.folder});

  FileModel.fromJson(Map<String, dynamic> json) {
    files = json['files'].cast<String>();
    folder = json['folderName'];
  }
}

class ImagePickerPage extends StatefulWidget {
//  ImagePickerPage({Key key, this.title}) : super(key: key);

//  final String title;

  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  List<FileModel> files = [];
  FileModel? selectedModel;
  String? image;
  List<String> _selectedList = [];
  @override
  void initState() {
    super.initState();
    getImagesPath();
  }

  getImagesPath() async {
    var imagePath = await StoragePath.imagesPath;
    var images = jsonDecode(imagePath!) as List;
    files = images.map<FileModel>((e) => FileModel.fromJson(e)).toList();
    if (files.length > 0)
      setState(() {
        selectedModel = files[0];
        image = files[0].files[0];
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: (){Navigator.pop(context);},
                      icon: Icon(Icons.clear),
                    ),
                    SizedBox(width: 10),
                    DropdownButtonHideUnderline(
                        child: DropdownButton<FileModel>(
                          items: getItems(),
                          onChanged: (FileModel? d) {
                            if (d == null) return;
                            assert(d.files.length > 0);
                            image = d.files[0];
                            setState(() {
                              selectedModel = d;
                            });
                          },
                          value: selectedModel,
                        ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: (){
                      print(_selectedList);
                    },
                    icon: Icon(Icons.check, color: Colors.blue,),
                  ),
                )
              ],
            ),
            Divider(),
            Container(
                height: MediaQuery.of(context).size.height * 0.45,
                child: image != null
                    ? Image.file(File(image!),
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: MediaQuery.of(context).size.width)
                    : Container()),
            Divider(),
            selectedModel == null || selectedModel!.files.length < 1
                ? Container()
                : Container(
              height: MediaQuery.of(context).size.height * 0.38,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4),
                  itemBuilder: (_, i) {
                    var file = selectedModel!.files[i];
                    return GestureDetector(
                      child: Image.file(
                        File(file),
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        setState(() {
                          image = file;
                        });
                      },
                      onLongPress: (){
                        _selectedList.add(file);
                      },
                    );
                  },
                  itemCount: selectedModel!.files.length),
            )
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<FileModel>> getItems() {
    return files
        .map((e) => DropdownMenuItem(
      child: Text(
        e.folder,
        style: TextStyle(color: Colors.black),
      ),
      value: e,
    ))
        .toList();
  }
}