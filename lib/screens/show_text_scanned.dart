import 'package:flutter/material.dart';
import 'package:your_second_eyes/screens/scan_screen.dart';

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
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 120),
            child: SizedBox(
              width: 340,
              height: 400,
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
                  child: Text(widget.textScanned,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 82, top: 530),
            child: SizedBox(
              width: 220,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                      width: 4,
                      color: Color.fromARGB(250, 2, 180, 186)
                  ),
                  shape: const StadiumBorder(),
                  backgroundColor: Color.fromARGB(250, 2, 180, 186)
                ),
                onPressed: () => Navigator.pop(context),
                child: Text('Tiếp tục quét',
                  style: TextStyle(
                    fontSize: 31,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}

