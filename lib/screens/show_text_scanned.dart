import 'package:flutter/material.dart';

class ShowTextScanned extends StatefulWidget {
  final String textScanned;
  const ShowTextScanned({Key? key, required this.textScanned}) : super(key: key);

  @override
  State<ShowTextScanned> createState() => _ShowTextScannedState();
}

class _ShowTextScannedState extends State<ShowTextScanned> {

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
          SingleChildScrollView(
            child: Text(widget.textScanned),
          )
        ],
      ),
    );
  }

}

