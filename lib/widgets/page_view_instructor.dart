import 'package:flutter/material.dart';
import 'package:your_second_eyes/screens/selection_screen.dart';
import 'package:your_second_eyes/screens/setting_screen.dart';

import '../screens/instruction_screen.dart';

class PageViewInstructor extends StatefulWidget {
  const PageViewInstructor({Key? key}) : super(key: key);

  @override
  State<PageViewInstructor> createState() => _PageViewInstructorState();
}

class _PageViewInstructorState extends State<PageViewInstructor> {
  double speedRate = 50;
  double volume = 50;
  final controller = PageController(
    initialPage: 0
  );

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      scrollDirection: Axis.horizontal,
      children: [
        InstructionScreen(),
        SettingScreen(speedRate: speedRate, volume: volume),
        SelectionScreen(speedRate: speedRate, volume: volume)
      ],
    );
  }
}
