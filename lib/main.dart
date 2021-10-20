import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_ml_vision/google_ml_vision.dart';

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
  String identifiedText = '';

  final ImagePicker _picker = ImagePicker();

  void _pickImage() async {
    final XFile image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image_to_Show = File(image.path);
    });
  }

  void extarctText() async {
    final GoogleVisionImage visionImage =
        GoogleVisionImage.fromFile(image_to_Show);
    final TextRecognizer textRecognizer =
        GoogleVision.instance.textRecognizer();
    final VisionText visionText =
        await textRecognizer.processImage(visionImage);
    String text = visionText.text;
    print(text);
    setState(() {
      identifiedText = text;
    });
    // for (TextBlock block in visionText.blocks) {
    //   final Rect boundingBox = block.boundingBox;
    //   final List<Offset> cornerPoints = block.cornerPoints;
    //   final String text = block.text;
    //   final List<RecognizedLanguage> languages = block.recognizedLanguages;

    //   for (TextLine line in block.lines) {
    //     // Same getters as TextBlock
    //     for (TextElement element in line.elements) {
    //       // Same getters as TextBlock
    //     }
    //   }
    // }
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
                child: identifiedText == ''
                    ? Text("Select an Image")
                    : Text(identifiedText),
              ),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text("Select Image"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    identifiedText = '';
                  });
                },
                child: Text("Clear"),
              ),
              ElevatedButton(
                onPressed: extarctText,
                child: Text("Extract Text"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
