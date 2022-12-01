import 'package:flutter/material.dart';
import 'package:your_second_eyes/screens/scan_screen.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
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
            padding: const EdgeInsets.only(top: 150, left: 20),
            child: SizedBox(
              width: 160,
              height: 220,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => ScanScreen(),
                        transitionDuration: const Duration(seconds: 1),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var begin = const Offset(0.0, 1.0);
                          var end = Offset.zero;
                          var curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      )
                  );
                },
                child: Text('1',
                  style: TextStyle(
                    fontSize: 180
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 4, color: Colors.blue),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(side: BorderSide(
                    color: Colors.blue,
                    width: 1,
                    style: BorderStyle.solid
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                  )
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150, left: 220),
            child: SizedBox(
              width: 160,
              height: 220,
              child: TextButton(
                onPressed: () {},
                child: Text('2',
                  style: TextStyle(
                      fontSize: 180
                  ),
                ),
                style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 4, color: Colors.blue),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(side: BorderSide(
                        color: Colors.blue,
                        width: 1,
                        style: BorderStyle.solid
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                    )
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 420, left: 120),
            child: SizedBox(
              width: 160,
              height: 220,
              child: TextButton(
                onPressed: () {},
                child: Text('3',
                  style: TextStyle(
                      fontSize: 180
                  ),
                ),
                style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 4, color: Colors.blue),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(side: BorderSide(
                        color: Colors.blue,
                        width: 1,
                        style: BorderStyle.solid
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                    )
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70, left: 15),
            child: Text('Lựa chọn tính năng',
              style: TextStyle(
                fontSize: 42,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
