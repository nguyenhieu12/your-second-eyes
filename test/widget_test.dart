// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:your_second_eyes/main.dart';
import 'package:your_second_eyes/screens/instruction_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Instruction screen', () {
    Widget testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: InstructionScreen())
    );
    testWidgets('Test instruction button', (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.tap(find.byKey(Key('instruction_button')));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: 3));
    });
  });
}
