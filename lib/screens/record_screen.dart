import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class RecordScreen extends StatefulWidget {
  const RecordScreen({Key? key}) : super(key: key);

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "Chạm và nói";
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
            size: 40,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Color.fromARGB(250, 32, 178, 170),
        centerTitle: true,
        title: Text('Chuyển đổi giọng nói',
          style: TextStyle(
              fontSize: 31,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 110),
        child: AvatarGlow(
          animate: true,//_isListening,
          glowColor: Colors.blue,
          endRadius: 60,
          duration: const Duration(milliseconds: 2000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: FloatingActionButton(
            onPressed: _listen,
            child: Icon(_isListening ? Icons.mic : Icons.mic_none,
              size: 50,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Image(
            image: AssetImage('assets/background.png'),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, top: 10),
            child: SizedBox(
              width: 380,
              height: 450,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20)
                    ),
                    border: Border.all(
                        width: 5,
                        color: Color.fromARGB(200, 0, 158, 191)
                    ),
                    color: Colors.white
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text('',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 70
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 480, left: 60),
            child: Text('Chạm và nói',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent
              ),
            ),
          )
        ],
      ),
    );
  }

  void _listen() async {
    if(!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val')
      );
      if(available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if(val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          })
        );
      } else {
        setState(() {
          _isListening = false;
        });
        _speech.stop();
      }
    }
  }
}




