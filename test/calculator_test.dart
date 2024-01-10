import 'package:example_widget_testing/app/modules/calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'test_library.dart';

void main() {
  testWidgets('Check if Calculator is functioning',
      (WidgetTester tester) async {
    FlutterError.onError = customFlutterErrorHandler;

    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        const MaterialApp(
          home: SimpleCalculator(),
        ),
      ),
    );

    const variableA = '2';
    const variableB = '3';
    const result = '5';
    final variableAField = find.byKey(const Key('variableA'));
    final variableBField = find.byKey(const Key('variableB'));
    var resultTextFinder = find.byKey(const Key('result'));
    checkByKeyFindOneWidget(resultTextFinder);

    await tester.enterText(variableAField, variableA);
    await tester.enterText(variableBField, variableB);
    await tester.tap(find.byKey(const Key('addButton')));
    await tester.pumpAndSettle();

    var resultText = resultTextFinder.evaluate().first.widget as Text;
    checkByKeyIsWidget(resultText, isA<Text>());
    // expect(find.text(result), findsOneWidget);
    checkWidgetProperty("data", resultTextFinder, resultText.data, result);
  });
}
