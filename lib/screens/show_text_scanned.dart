import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ShowTextScanned extends StatefulWidget {
  final String textScanned;
  const ShowTextScanned({Key? key, required this.textScanned}) : super(key: key);

  @override
  State<ShowTextScanned> createState() => _ShowTextScannedState();
}

class _ShowTextScannedState extends State<ShowTextScanned> {
  final FlutterTts flutterTts = FlutterTts();

  speak() async {
    await flutterTts.setLanguage('vi-VN');
    await flutterTts.setPitch(1.0);
    await flutterTts.setVolume(1.0);
    await flutterTts.speak(widget.textScanned);
  }

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
            padding: const EdgeInsets.only(left: 5, top: 130),
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
                  child: Text(widget.textScanned != "" ?
                      widget.textScanned : 'Không có văn bản trên hình',
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
            padding: const EdgeInsets.only(left: 10, top: 600),
            child: SizedBox(
              width: 170,
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
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: widget.textScanned));
                },
                child: Text('Sao chép',
                  style: TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 200, top: 600),
            child: SizedBox(
              width: 170,
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
                onPressed: () => speak(),
                child: Text('Phát âm',
                  style: TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 82, top: 680),
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

