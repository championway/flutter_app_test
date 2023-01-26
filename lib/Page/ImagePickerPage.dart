import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_test/Util/Util.dart';
import 'package:flutter_storage_path/flutter_storage_path.dart';

class FileModel {
  List<String> filePathList = [];
  String folder = "";

  FileModel({required this.filePathList, required this.folder});

  FileModel.fromJson(Map<String, dynamic> json) {
    filePathList = json['files'].cast<String>();
    folder = json['folderName'];
  }
}

class ImageSelectModel {
  ImageSelectModel(
      {required this.path, this.isSelect: false, this.selectOrder: 0});

  String path;
  bool isSelect;
  int selectOrder; // 0 --> not selected
}

class ImagePickerPage extends StatefulWidget {
//  ImagePickerPage({Key key, this.title}) : super(key: key);

//  final String title;

  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  static const int MAX_SELECT_NUM = 7;
  List<FileModel> _allFileList = [];
  FileModel? _fileListModel;
  String? _currentImagePath;

  List<String> _selectedPathList = [];
//  List<ImageSelectModel> _selectedImageList = [];
//  int _totalSelectedOrder = 0;

  @override
  void initState() {
    super.initState();
    getImagesPath();
  }

  getImagesPath() async {
    var imagePath = await StoragePath.imagesPath;
    var images = jsonDecode(imagePath!) as List;
    _allFileList = images.map<FileModel>((e) => FileModel.fromJson(e)).toList();
    if (_allFileList.length > 0) {
//      for (String path in _allFileList[0].filePathList) {
//        if (_selectedPathList.contains(path)) {
//          for (int i = 0; i < _se.length; i++) {
//            if (_imageList[i].path == path) {
//              _imageList
//            }
//          }
//        }
//      }
      setState(() {
        _fileListModel = _allFileList[0];
        _currentImagePath = _allFileList[0].filePathList[0];
      });
    }
  }

  Widget imageThumbnailWidget(String path) {
    int order = 0;
    bool isSelect = _selectedPathList.contains(path);
    if (isSelect) order = _selectedPathList.indexOf(path) + 1;
    return Stack(
      children: [
        Image.file(
          File(path),
          fit: BoxFit.cover,
        ),
        Visibility(
            visible: isSelect,
            child: Positioned(right: 3, top: 3, child: Text("$order")))
      ],
    );
  }

  void selectedImageFunction(String path) {
    if (!_selectedPathList.contains(path)) {
      // if this image haven't been selected
      if (_selectedPathList.length >= MAX_SELECT_NUM) {
        // already select maximum amount
        showToast("上限是$MAX_SELECT_NUM張照片");
        return;
      }
      setState(() {
        _selectedPathList.add(path);
      });
    } else {
      // if this image already been selected
      setState(() {
        _selectedPathList.remove(path);
//        _selectedImageList.removeWhere((element) => element.path == path);
      });
    }
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.clear),
                    ),
                    SizedBox(width: 10),
                    DropdownButtonHideUnderline(
                        child: DropdownButton<FileModel>(
                      items: getItems(),
                      onChanged: (FileModel? d) {
                        if (d == null) return;
                        assert(d.filePathList.length > 0);
                        _currentImagePath = d.filePathList[0];
                        setState(() {
                          _fileListModel = d;
                        });
                      },
                      value: _fileListModel,
                    ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
//                      print(_selectedList);
                    },
                    icon: Icon(
                      Icons.check,
                      color: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
            Divider(),
            Container(
                height: MediaQuery.of(context).size.height * 0.45,
                child: _currentImagePath != null
                    ? Image.file(File(_currentImagePath!),
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: MediaQuery.of(context).size.width)
                    : Container()),
            Divider(),
            _fileListModel == null ||
                    _fileListModel!.filePathList.length < 1 // TODO
                ? Container()
                : Container(
                    height: MediaQuery.of(context).size.height * 0.38,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4),
                        itemBuilder: (_, i) {
                          String path = _fileListModel!.filePathList[i];
                          return GestureDetector(
                            child: imageThumbnailWidget(path),
                            onTap: () {
                              setState(() {
                                _currentImagePath = path;
                              });
                            },
                            onLongPress: () {
                              selectedImageFunction(path);
                            },
                          );
                        },
                        itemCount: _fileListModel!.filePathList.length),
                  )
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<FileModel>> getItems() {
    return _allFileList
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
