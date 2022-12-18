import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class InstructionScreen extends StatefulWidget {
  const InstructionScreen({Key? key}) : super(key: key);

  @override
  State<InstructionScreen> createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  final FlutterTts flutterTts = FlutterTts();
  final instructionText = "Hướng dẫn sử dụng ứng dụng. Lướt sang trái để cài đặt, tiếp tục lướt sang trái để chọn tính năng 1 để quét văn bản 2 để kiểm tra thị lực 3 để ghi âm giọng nói";

  speak() async {
    await flutterTts.setLanguage("vi-VN");
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(0.0);
    await flutterTts.speak(instructionText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: AssetImage('assets/intro_background.png'),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Text('Chạm để nghe',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 60
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 190),
            child: IconButton(
              key: Key('instruction_button'),
              icon: Image.asset('assets/instructor_button.png'),
              iconSize: 400,
              onPressed: () => speak(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100, top: 580),
            child: Icon(Icons.arrow_back,
              size: 200,
              color: Color.fromARGB(200, 0, 158, 191),
            ),
          )
        ],
      ),
    );
  }
}