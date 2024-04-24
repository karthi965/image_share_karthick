import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class ImagePickershare extends StatefulWidget {
  const ImagePickershare({Key? key}) : super(key: key);

  @override
  State<ImagePickershare> createState() => _ImagePickershareState();
}

class _ImagePickershareState extends State<ImagePickershare> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Image Picker',
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print("-------------------->clicked share");
              _shareInfo();
            },
            icon: Icon(
              Icons.share_outlined,
              size: 18,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _imageFile == null
                  ? Text('no image selected')
                  : Image.file(_imageFile!),
              ElevatedButton(
                onPressed: () {
                  print('image file pick form gallery button clicked');
                  _imageFrom(ImageSource.gallery);
                },
                child: Text('Image pick from gallery'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print('image file pick form camera button clicked');
                  _imageFrom(ImageSource.camera);
                },
                child: Text('Image from camera'),
              ),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }

  void _imageFrom(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      setState(() {
        if (pickedFile != null) {
          _imageFile = File(pickedFile.path);
        } else {
          print('no image clicked');
        }
      });
    } catch (e) {
      print('error image picked');
    }
  }

  void _shareInfo() {
    print("----------->share");
    if (_imageFile != null) {
      Share.shareFiles([_imageFile!.path]);
    } else {
      print("No image selected to share.");
    }
  }
}
