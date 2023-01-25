import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_test/Util/Util.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as IMG;

class PhotoEditorPage extends StatefulWidget {
  @override
  _PhotoEditorPageState createState() => _PhotoEditorPageState();
}

class _PhotoEditorPageState extends State<PhotoEditorPage> {
  File? _image;
  File? _showImage;
  IMG.Image? _img;
  List<int>? _listInt;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      setState(() {
        _image = img;
        _showImage = _image;
//        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
//      Navigator.of(context).pop();
    }
  }

  IMG.Image? fileToImage(File? file){
    if (file == null) return null;
    return IMG.decodeImage(file.readAsBytesSync());
  }

  Uint8List? intListToUInt8List(List<int>? list){
    if (list == null) return null;
    Uint8List.fromList(list);
  }

  void editImage() async {
    if (_showImage == null) return;
    IMG.Image? img = IMG.decodeImage(_showImage!.readAsBytesSync());
    if (img != null) {
      showToast("Edit");
//      print(img.height);
//      print(img.width);
//      IMG.Image? thumbnail = IMG.copyResize(img, width: 120);
      IMG.Image thumbnail = IMG.copyResize(img, width: 150, height: 100);
//      print(thumbnail.height);
//      print(thumbnail.width);
//      print("======");
//      File('thumbnail-test.png')
//        ..writeAsBytesSync(IMG.encodePng(thumbnail));
//      File file = File.fromRawPath(Uint8List.fromList(IMG.encodePng(img)));
      setState(() {
        _listInt = IMG.encodePng(thumbnail);
        _img = img;
//        _showImage = file;
        showToast("Done");
      });
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path, compressFormat: ImageCompressFormat.jpg
//        aspectRatioPresets: Platform.isAndroid
//            ? [
//          CropAspectRatioPreset.square,
//          CropAspectRatioPreset.ratio3x2,
//          CropAspectRatioPreset.original,
//          CropAspectRatioPreset.ratio4x3,
//          CropAspectRatioPreset.ratio16x9
//        ]
//            : [
//          CropAspectRatioPreset.original,
//          CropAspectRatioPreset.square,
//          CropAspectRatioPreset.ratio3x2,
//          CropAspectRatioPreset.ratio4x3,
//          CropAspectRatioPreset.ratio5x3,
//          CropAspectRatioPreset.ratio5x4,
//          CropAspectRatioPreset.ratio7x5,
//          CropAspectRatioPreset.ratio16x9
//        ],
//      androidUiSettings: AndroidUiSettings(
//          toolbarTitle: 'Cropper',
//          toolbarColor: Colors.deepOrange,
//          toolbarWidgetColor: Colors.white,
//          initAspectRatio: CropAspectRatioPreset.original,
//          lockAspectRatio: false),
//      iosUiSettings: IOSUiSettings(
//        title: 'Cropper',
//      ),
        );
    if (croppedFile != null) {
//      return File(croppedFile.path);
//      imageFile = croppedFile;
      showToast("Cropped");
      setState(() {
        _showImage = croppedFile;
      });
    }
  }

  _cropImageWithSize(){
    if (_showImage == null) return;
    IMG.Image? img = IMG.decodeImage(_showImage!.readAsBytesSync());
    IMG.Image cropImg =  IMG.copyCrop(img!, 5, 10, 50, 80);
    setState(() {
      _listInt = IMG.encodePng(cropImg);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Editor"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      _pickImage(ImageSource.camera);
                    },
                    icon: Icon(Icons.camera_alt_outlined)),
                IconButton(
                    onPressed: () {
                      _pickImage(ImageSource.gallery);
                    },
                    icon: Icon(Icons.photo)),
                IconButton(
                    onPressed: () {
                      if (_image != null) {
                        _cropImage(imageFile: _image!);
                      }
                    },
                    icon: Icon(Icons.crop)),
                IconButton(
                    onPressed: () {
                      if (_image != null) {
                        editImage();
                      }
                    },
                    icon: Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      _cropImageWithSize();
                    },
                    icon: Icon(Icons.crop))
              ],
            ),
            _listInt != null
                ? Image.memory(Uint8List.fromList(_listInt!))
                : (_showImage != null
                    ? Image.file(_showImage!)
                    : SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
