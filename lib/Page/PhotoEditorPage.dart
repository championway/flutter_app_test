import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  void editImage() async{
    if (_image == null) return;
    IMG.Image? img = IMG.decodeImage(_image!.readAsBytesSync());
    if (img != null) {
      print(img.height);
      print(img.width);
      img = IMG.copyResize(img, width: 500, height: 500);
      File file = File.fromRawPath(img.getBytes());
      setState(() {
        _showImage = file;
      });
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    File? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
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
      return File(croppedFile.path);
//      imageFile = croppedFile;
//      setState(() {
//        _image = imageFile;
//      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Photo Editor"),),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        },
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(onPressed: (){
                  _pickImage(ImageSource.camera);
                }, icon: Icon(Icons.camera_alt_outlined)),
                IconButton(onPressed: (){
                  _pickImage(ImageSource.gallery);
                }, icon: Icon(Icons.photo)),
                IconButton(onPressed: (){
                  if (_image != null) {
                    _cropImage(imageFile: _image!);
                  }
                }, icon: Icon(Icons.crop)),
                IconButton(onPressed: (){
                  if (_image != null) {
                    editImage();
                  }
                }, icon: Icon(Icons.edit))
              ],
            ),
            _showImage != null ? Image.file(_showImage!) : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
