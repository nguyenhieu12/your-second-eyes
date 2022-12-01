import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:your_second_eyes/screens/show_text_scanned.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({Key? key}) : super(key: key);

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  late stt.SpeechToText _speechToText;
  bool _isListening = false;
  String _text = 'Press';
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speechToText = stt.SpeechToText();
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
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
          animate: _isListening,
          glowColor: Colors.red,
          endRadius: 75.0,
          duration: const Duration (milliseconds: 2000),
          repeatPauseDuration: const Duration (milliseconds: 100),
          repeat: true,
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(_isListening ? Icons.mic : Icons.mic_none),
          )
      ),

    );
  }

  void _listen() async {
    if(!_isListening) {
      bool available = await _speechToText.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val')
      );
      if(available) {
        setState(() {
          _isListening = true;
        });
        _speechToText.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if(val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          })
        );
      }
    } else {
      setState(() {
        _isListening = false;
      });
      _speechToText.stop();
    }
  }
}

