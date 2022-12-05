import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class InstructionScreen extends StatefulWidget {
  const InstructionScreen({Key? key}) : super(key: key);

  @override
  State<InstructionScreen> createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  final FlutterTts flutterTts = FlutterTts();
  final instructionText = "Hướng dẫn sử dụng";

  speak() async {
    await flutterTts.setLanguage("vi-VN");
    await flutterTts.setPitch(1.0);
    await flutterTts.setVolume(1.0);
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
            padding: const EdgeInsets.only(left: 15, top: 120),
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
            padding: const EdgeInsets.only(left: 10, top: 200),
            child: IconButton(
              icon: Image.asset('assets/instructor_button.png'),
              iconSize: 370,
              onPressed: () => speak(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100, top: 570),
            child: Icon(Icons.arrow_back,
              size: 200,
              color: Color.fromARGB(200, 0, 158, 191),
            ),
          )
          // Padding(
          //   padding: const EdgeInsets.only(left: 50, top: 600),
          //   child: Image.asset('assets/blue_arrow.png',
          //     width: 280,
          //     height: 120,
          //   )
          // )
        ],
      ),
    );
  }
}
