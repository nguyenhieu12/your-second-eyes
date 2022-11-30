import 'package:flutter/material.dart';
import 'package:your_second_eyes/screens/setting_screen.dart';

class ShowTextScreen extends StatelessWidget {
  const ShowTextScreen({Key? key});

  static late String _text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: AssetImage('assets/show_text_background.png'),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          TextButton(
            child: Text('Change',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 50
                )
            ),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  setText(String text) {
    _text = text;
  }
}
