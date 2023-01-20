import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PhotoEditorPage extends StatefulWidget {
  @override
  _PhotoEditorPageState createState() => _PhotoEditorPageState();
}

class _PhotoEditorPageState extends State<PhotoEditorPage> {
  File? _image;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      setState(() {
        _image = img;
//        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
//      Navigator.of(context).pop();
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
                }, icon: Icon(Icons.crop))
              ],
            ),
            _image != null ? Image.file(_image!) : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
