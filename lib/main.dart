import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyPage());
}

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  /// Variables
  File imageFile;

  /// Widget
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Image Picker"),
          ),
          body: Container(
              child: imageFile == null
                  ? Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            color: Colors.greenAccent,
                            onPressed: () {
                              _getFromGallery();
                            },
                            child: const Text("PICK FROM GALLERY"),
                          ),
                          Container(
                            height: 40.0,
                          ),
                          RaisedButton(
                            color: Colors.lightGreenAccent,
                            onPressed: () {
                              _getFromCamera();
                            },
                            child: const Text("PICK FROM CAMERA"),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Container(
                          child: Image.file(
                            imageFile,
                            fit: BoxFit.cover,
                          ),
                        ),
                        RaisedButton(
                          color: Colors.lightBlueAccent,
                          onPressed: () {
                            _setClearImage();
                          },
                          child: const Text("Clear Image"),
                        )
                      ],
                    ))),
    );
  }

  /// Get from gallery
  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  _setClearImage() async {
    setState(() {
      imageFile = null;
    });
  }
}
