import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class InstructionScreen extends StatefulWidget {
  const InstructionScreen({Key? key}) : super(key: key);

  @override
  State<InstructionScreen> createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  final FlutterTts flutterTts = FlutterTts();
  final instructionText = "";

  speak() async {
    await flutterTts.setLanguage("vi-VN");
    await flutterTts.setPitch(1);
    await flutterTts.setVolume(1);
    await flutterTts.speak(instructionText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: AssetImage('assets/background.png'),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 180),
            child: DefaultTextStyle(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 42,
                  color: Colors.black
              ),
              child: Text('Hướng dẫn sử dụng'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 250),
            child: IconButton(
              icon: Image.asset('assets/instructor_button.png'),
              iconSize: 370,
              onPressed: () => speak(),
            ),
          )
        ],
      ),
    );
  }
}
