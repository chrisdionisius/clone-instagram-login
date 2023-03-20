import 'package:example_widget_testing/app/modules/login/components/language_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Check if language dropdown is present',
    (tester) async {
      // choose the widget to be tested
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LanguageDropdown(),
          ),
        ),
      );

      // execute the test
      final dropdownButtonFinder = find.byType(DropdownButton<String>);
      final dropdownButton = dropdownButtonFinder.evaluate().first.widget
          as DropdownButton<String>;
      // check if dropdownButtonFinder has icon

      // check the widget
      expect(dropdownButtonFinder, findsOneWidget);
      expect(dropdownButton.dropdownColor, Colors.white);
      expect(dropdownButton.style!.color, Colors.black54);
      expect(dropdownButton.elevation, 10);
      expect(dropdownButton.items!.length, 4);
      expect(dropdownButton.items![0].value, 'English');
      expect(dropdownButton.items![1].value, 'Arabic');
      expect(dropdownButton.items![2].value, 'Italian');
      expect(dropdownButton.items![3].value, 'French');
      // check if DropdownMenuItem<String> has Text widget
      expect(dropdownButton.items![0].child, isA<Text>());
      expect(dropdownButton.items![1].child, isA<Text>());
      expect(dropdownButton.items![2].child, isA<Text>());
      expect(dropdownButton.items![3].child, isA<Text>());
      // check if Text widget has correct text
      expect((dropdownButton.items![0].child as Text).data, 'English');
      expect((dropdownButton.items![1].child as Text).data, 'Arabic');
      expect((dropdownButton.items![2].child as Text).data, 'Italian');
      expect((dropdownButton.items![3].child as Text).data, 'French');
      // check if Text widget has correct style
      expect((dropdownButton.items![0].child as Text).style!.fontSize, 16);
      expect((dropdownButton.items![1].child as Text).style!.fontSize, 16);
      expect((dropdownButton.items![2].child as Text).style!.fontSize, 16);
      expect((dropdownButton.items![3].child as Text).style!.fontSize, 16);
    },
  );

  testWidgets(
    'Check if username textbox is present',
    (tester) async {
      // choose the widget to be tested
      // await tester.pumpWidget(
      //   MaterialApp(
      //       // double width = MediaQuery.of(context).size.width,

      //       // home: Scaffold(

      //       //     body: UsernameTextbox(),
      //       //     ),
      //       ),
      // );

      // execute the test
      // final dropdownButtonFinder = find.byType(DropdownButton<String>);
      // check if dropdownButtonFinder has icon

      // check the widget
    },
  );

  testWidgets(
    'Check if username textbox is present',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
              // body: LoginButton(inputTextNotNull: 0, openHomePage: 0, buttonColor: 0, onPressed: () { void },),
              ),
        ),
      );
    },
  );

  // check if password textbox is present
}
