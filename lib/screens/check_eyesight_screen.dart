import 'package:flutter/material.dart';
import 'package:your_second_eyes/screens/selection_screen.dart';

import '../models/Option.dart';
import '../models/Question.dart';

class CheckEyesightScreen extends StatefulWidget {
  const CheckEyesightScreen({Key? key}) : super(key: key);

  @override
  State<CheckEyesightScreen> createState() => _CheckEyesightScreenState();
}

class _CheckEyesightScreenState extends State<CheckEyesightScreen> {
  late PageController _controller;
  int _questionNumber = 1;
  int _score = 0;
  bool _isLocked = false;
  late List<Question> questions;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    questions = listQuestions;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          image: AssetImage('assets/background.png'),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 10),
              DefaultTextStyle(
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 50
                ),
                child: Text('Câu hỏi $_questionNumber/${questions.length}')
              ),
              Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: questions.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final _question = questions[index];
                      return buildQuestion(_question);
                    },
                  )
              ),
              _isLocked ? Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: buildElevatedButton(),
              ) : const SizedBox.shrink()
            ],
          ),
        ),
        //buildElevatedButton()
      ]
    );
  }

  Column buildQuestion(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTextStyle(
          style: TextStyle(
              fontSize: 40,
              color: Colors.black
          ),
          child: Text(question.text),
        ),
        Expanded(
          child: OptionWidget(
            question: question,
            onClickedOption: (option) {
              if(question.isLocked) {
                return;
              } else {
                setState(() {
                  question.isLocked = true;
                  question.selectedOption = option;
                });
                _isLocked = question.isLocked;
                if(question.selectedOption!.isCorrect) {
                  _score++;
                }
              }
            },
          ),
        )
      ],
    );
  }

  SizedBox buildElevatedButton() {
    return SizedBox(
      width: 180,
      height: 80,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          //maximumSize: Size(150, 150),
          minimumSize: Size(100, 80),
          //minimumSize: Size(100, 50),
          shape: const StadiumBorder(),
          side: BorderSide(color: Colors.blue, width: 4)
        ),
        onPressed: () {
          if(_questionNumber < questions.length) {
            _controller.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInExpo
            );

            setState(() {
              _questionNumber++;
              _isLocked = false;
            });
          } else {
            Navigator.push(context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => ResultScreen(score: _score, questions: questions),
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
          }
        },
        child: Text(_questionNumber < questions.length
            ? 'Tiếp tục' : 'Kết quả',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.blue
          ),
        ),
      ),
    );
  }


}

class OptionWidget extends StatefulWidget {
  final Question question;
  final ValueChanged<Option> onClickedOption;

  const OptionWidget({
    Key? key,
    required this.question,
    required this.onClickedOption
  }) : super(key: key);

  @override
  State<OptionWidget> createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: widget.question.options
              .map((option) => buildOption(context, option)).toList()
      ),
    );

  }
  // @override
  Widget buildOption(BuildContext context, Option option) {
    final color = getColorForOption(option, widget.question);
    return GestureDetector(
      onTap: () => widget.onClickedOption(option),
      child: Padding(
        padding: const EdgeInsets.only(left: 130, top: 20),
        child: Container(
          height: 95,
          width: 95,
          //margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
                color: color,//Color.fromARGB(200, 0, 158, 191),
                width: 4
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 20),
              DefaultTextStyle(
                child: Text(option.text),
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.black
                ),
              ),
              getIconForOption(option, widget.question)
            ],
          ),
        ),
      ),
    );
  }

  Color getColorForOption(Option option, Question question) {
    final isSelected = option == question.selectedOption;
    if(question.isLocked) {
      if(isSelected) {
        return option.isCorrect ? Colors.green : Colors.red;
      } else if(option.isCorrect) {
        return Colors.green;
      }
    }

    return Colors.white;
  }

  Widget getIconForOption(Option option, Question question) {
    final isSelected = option == question.selectedOption;
    if(question.isLocked) {
      if(isSelected) {
        return option.isCorrect
            ? const Icon(Icons.check_circle, color: Colors.green, size: 20)
            : const Icon(Icons.cancel, color: Colors.red, size: 20);
      } else if(option.isCorrect) {
        return const Icon(Icons.check_circle, color: Colors.green, size: 20);
      }
    }

    return const SizedBox.shrink();
  }
}


class ResultScreen extends StatelessWidget {
  final List<Question> questions;
  final int score;

  const ResultScreen({
    Key? key,
    required this.score,
    required this.questions
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          image: AssetImage('assets/background.png'),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Center(
          child: DefaultTextStyle(
            child: Text('Điểm của bạn: $score/${questions.length}'),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 45,
              color: Colors.black
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 450, left: 120),
          child: ElevatedButton(
            style: OutlinedButton.styleFrom(
                side: BorderSide(width: 4, color: Color.fromARGB(250, 0, 158, 191)),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(side: BorderSide(
                    color: Colors.blue,
                    width: 1,
                    style: BorderStyle.solid
                ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                )
            ),
            onPressed: () {
              Navigator.push(context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => SelectionScreen(speedRate: 50, volume: 50),
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
            child: SizedBox(
              width: 120,
              height: 80,
              child: Column(
                children: [
                  SizedBox(height: 15),
                  Center(
                    child: Text('Trở lại',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.black
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
    // return Scaffold(
    //     body: Column(
    //       children: [
    //         Center(
    //           child: Text('Điểm của bạn: $score/${questions.length}'),
    //         ),
    //         ElevatedButton(
    //           onPressed: () {
    //             Navigator.push(context,
    //                 PageRouteBuilder(
    //                   pageBuilder: (_, __, ___) => SelectionScreen(speedRate: 50, volume: 50),
    //                   transitionDuration: const Duration(seconds: 1),
    //                   transitionsBuilder:
    //                       (context, animation, secondaryAnimation, child) {
    //                     var begin = const Offset(0.0, 1.0);
    //                     var end = Offset.zero;
    //                     var curve = Curves.ease;
    //
    //                     var tween = Tween(begin: begin, end: end)
    //                         .chain(CurveTween(curve: curve));
    //
    //                     return SlideTransition(
    //                       position: animation.drive(tween),
    //                       child: child,
    //                     );
    //                   },
    //                 )
    //             );
    //           }, child: Text('Quay về trang lựa chọn'),
    //         )
    //       ],
    //     )
    // );
  }
}

final listQuestions = [
  Question(
      text: 'Chọn chữ cái sau đây: A',
      options: [
        const Option(text: 'B', isCorrect: false),
        const Option(text: 'C ', isCorrect: false),
        const Option(text: 'D', isCorrect: false),
        const Option(text: 'A', isCorrect: true),
      ]
  ),
  Question(
      text: 'Chọn từ sau đây: Ai',
      options: [
        const Option(text: 'Ăi', isCorrect: false),
        const Option(text: 'Âi', isCorrect: false),
        const Option(text: 'Ai', isCorrect: true),
        const Option(text: 'A', isCorrect: false),
      ]
  ),
  Question(
      text: 'Chọn từ sau đây: Bum',
      options: [
        const Option(text: 'Bưm', isCorrect: false),
        const Option(text: 'Bum', isCorrect: true),
        const Option(text: 'Bơm', isCorrect: false),
        const Option(text: 'Bôm', isCorrect: false),
      ]
  ),
  Question(
      text: 'Chọn từ sau đây: Vấn',
      options: [
        const Option(text: 'Vấn', isCorrect: true),
        const Option(text: 'Vắn', isCorrect: false),
        const Option(text: 'Vứn', isCorrect: false),
        const Option(text: 'Vớn', isCorrect: false),
      ]
  ),
  Question(
      text: 'Chọn từ sau đây: Mặt',
      options: [
        const Option(text: 'Mật', isCorrect: false),
        const Option(text: 'Mặt', isCorrect: true),
        const Option(text: 'Mặc', isCorrect: false),
        const Option(text: 'Mậc', isCorrect: false),
      ]
  )
];
