import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_test/Util/Util.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as IMG;
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';

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

  IMG.Image? fileToImage(File? file) {
    if (file == null) return null;
    return IMG.decodeImage(file.readAsBytesSync());
  }

  Uint8List? intListToUInt8List(List<int>? list) {
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

  Rect getImageCroppingRect({required double ratio, required double width, required double height}) {
    double origRatio = width / height;
    double rectL = 0, rectR = 1, rectT = 0, rectB = 1;
    if (origRatio > ratio) {
      // crop width
      double croppingWidth = height * ratio;
      double croppingRatio = (width - croppingWidth) / width;
      rectL = croppingRatio / 2;
      rectR = 1 - rectL;
    } else {
      // crop height
      double croppingHeight = width / ratio;
      double croppingRatio = (height - croppingHeight) / height;
      rectT = croppingRatio / 2;
      rectB = 1 - rectT;
    }
    print("$rectL, $rectT, $rectR, $rectB");
    return Rect.fromLTRB(rectL, rectT, rectR, rectB);
  }

  _cropImageWithSize1() async {
    if (_image == null) return;
    final origSize = ImageSizeGetter.getSize(FileInput(_image!));
    print(origSize);
    final stopwatch = Stopwatch();
    stopwatch.start();
    File croppedFile = await ImageCrop.cropImage(
      file: _image!,
      area: getImageCroppingRect(ratio: 1, width: (origSize.width).toDouble(), height: (origSize.height).toDouble()),
    );
    print("cropImage : ${stopwatch.elapsedMilliseconds}"); // Likely > 0.
    stopwatch.reset();
    final cropSize = ImageSizeGetter.getSize(FileInput(croppedFile));
    print("getSize : ${stopwatch.elapsedMilliseconds}"); // Likely > 0.
    print('$cropSize');
    stopwatch.stop();
    setState(() {
      _showImage = croppedFile;
    });
  }

  _cropImageWithSize2() {
    if (_image == null) return;
    final stopwatch1 = Stopwatch();
    stopwatch1.start();
    final stopwatch = Stopwatch();
    stopwatch.start();
    IMG.Image? img = IMG.decodeImage(_image!.readAsBytesSync());
    print("Decode : ${stopwatch.elapsedMilliseconds}"); // Likely > 0.
    stopwatch.reset();
    IMG.Image cropImg = IMG.copyCrop(img!, 5, 10, 550, 580);
    print("CopyCrop : ${stopwatch.elapsedMilliseconds}"); // Likely > 0.
    stopwatch.reset();
    _listInt = IMG.encodePng(cropImg);
    print("Encode : ${stopwatch.elapsedMilliseconds}"); // Likely > 0.
    stopwatch.stop();
    print("Total : ${stopwatch1.elapsedMilliseconds}"); // Likely > 0.
    stopwatch1.stop();
    setState(() {});
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
                      _cropImageWithSize1();
                    },
                    icon: Icon(Icons.crop)),
                IconButton(
                    onPressed: () {
                      _cropImageWithSize2();
                    },
                    icon: Icon(Icons.crop))
              ],
            ),
            _listInt != null
                ? Image.memory(Uint8List.fromList(_listInt!))
                : (_showImage != null
                    ? Image.file(
                        _showImage!,
                        cacheWidth: 640,
                      )
                    : SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
