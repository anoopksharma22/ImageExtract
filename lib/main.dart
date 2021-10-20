import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File image_to_Show;
  final ImagePicker _picker = ImagePicker();
  void _pickImage() async {
    final XFile image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image_to_Show = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ImagePicker",
      home: Scaffold(
        appBar: AppBar(
          title: Text("ImagePicker"),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                child: image_to_Show != null
                    ? Image.file(image_to_Show)
                    : Text("Select Iamge"),
              ),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text("Select Image"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    image_to_Show = null;
                  });
                },
                child: Text("Clear"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
