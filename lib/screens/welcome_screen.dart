import 'dart:async';

import 'package:flutter/material.dart';
import 'package:your_second_eyes/screens/instruction_screen.dart';
import 'package:your_second_eyes/widgets/page_view_instructor.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
          PageViewInstructor())).then((value) {});
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          image: AssetImage('assets/welcome_background.png'),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 170, top: 620),
          child: CircularProgressIndicator(

          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 125, top: 680),
          child: DefaultTextStyle(
            child: Text('Waiting 5s'),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 28
            ),
          ),
        )
      ],
    );
  }
}
