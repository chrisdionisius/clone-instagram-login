import 'package:example_widget_testing/app/modules/calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Change dropdown value', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SimpleCalculator(),
        ),
      );

      const variableA = '2';
      const variableB = '3';
      const result = '5';

      // find text field with key variableA
      final Finder variableAField = find.byKey(const Key('variableA'));

      // expect text field is found
      expect(variableAField, findsOneWidget);

      // find text field with key variableB
      final Finder variableBField = find.byKey(const Key('variableB'));

      // expect text field is found
      expect(variableBField, findsOneWidget);

      // enter text 2
      await tester.enterText(variableAField, variableA);

      // enter text 3
      await tester.enterText(variableBField, variableB);

      // find button with key addButton
      final Finder addButton = find.byKey(const Key('addButton'));

      // expect button is found
      expect(addButton, findsOneWidget);

      // tap on button
      await tester.tap(addButton);

      // move to next frame
      await tester.pumpAndSettle();

      // find text with key result
      final Finder resultTextFinder = find.byKey(const Key('result'));

      // expect text is found
      expect(resultTextFinder, findsOneWidget);

      // expect text is 5
      expect(find.text(result), findsOneWidget);
    });
  });
}
