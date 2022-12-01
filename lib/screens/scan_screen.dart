import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:your_second_eyes/screens/show_text_scanned.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool textScanning = false;

  XFile? imageFile;

  String scannedText = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(250, 32, 178, 170),
        centerTitle: true,
        title: Text('READING EVERYTHING',
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Center(
              child: Text('SCANNING TEXT',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                  color: Colors.black
                ),
              ),
            ),
          ),
          if(!textScanning && imageFile == null)
            Image(
              image: AssetImage('assets/scanning.png',),
              height: 380,
            )
          else if(imageFile != null)
            Image.file(
              File(imageFile!.path),
              height: 380,
            ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 60),
                child: ElevatedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 3, color: Colors.blue),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(side: BorderSide(
                          color: Colors.blue,
                          width: 1,
                          style: BorderStyle.solid
                      ),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      )
                  ),
                  onPressed: () {
                    getImage();
                  },
                  child: SizedBox(
                    width: 90,
                    height: 75,
                    child: Column(
                      children: [
                        SizedBox(height: 5),
                        Center(
                          child: Icon(
                              Icons.image,
                              size: 38,
                              color: Colors.grey
                          ),
                        ),
                        Center(
                          child: Text('Gallery',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 40),
                child: ElevatedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 3, color: Colors.blue),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(side: BorderSide(
                          color: Colors.blue,
                          width: 1,
                          style: BorderStyle.solid
                      ),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      )
                  ),
                  onPressed: () {},
                  child: SizedBox(
                    width: 90,
                    height: 75,
                    child: Column(
                      children: [
                        SizedBox(height: 5),
                        Center(
                          child: Icon(
                              Icons.camera_alt,
                              size: 38,
                              color: Colors.grey
                          ),
                        ),
                        Center(
                          child: Text('Camera',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          //Text('$scannedText')
        ],
      ),
    );
  }

  void getImage() async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        getRecognisedText(pickedImage);

        setState(() {});
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      setState(() {});
      scannedText = "Erroe occured while scanning";
    }
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    RecognizedText recognizedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    for(TextBlock block in recognizedText.blocks) {
      for(TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
      }
    }
    textScanning = false;
    Navigator.push(context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => ShowTextScanned(textScanned: scannedText),
          transitionDuration: const Duration(seconds: 1),
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            var begin = const Offset(0.0, 1.0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween = Tween(begin: begin, end: end)
                .chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        )
    );
    setState(() {});
  }
}
