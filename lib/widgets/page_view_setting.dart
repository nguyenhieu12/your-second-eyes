import 'package:flutter/material.dart';
import 'package:your_second_eyes/widgets/page_view_instructor.dart';

import '../screens/setting_screen.dart';

class PageViewSetting extends StatefulWidget {
  const PageViewSetting({Key? key}) : super(key: key);

  @override
  State<PageViewSetting> createState() => _PageViewSettingState();
}

class _PageViewSettingState extends State<PageViewSetting> {
  final controller = PageController(
    initialPage: 1,
  );

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      scrollDirection: Axis.horizontal,
      children: [
        PageViewInstructor(),
        SettingScreen()
      ],
    );
  }
}
