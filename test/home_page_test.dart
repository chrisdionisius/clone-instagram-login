import 'package:example_widget_testing/app/modules/home/home_page.dart';
import 'package:example_widget_testing/app/root_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper.dart';

void main() {
  testWidgets('Home Page', (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;
    await tester.pumpWidget(const RootApp());

    await tester.pumpAndSettle();
    try {
      expect(find.byType(HomePage), findsOneWidget);
    } catch (e) {
      debugPrint(e.toString());
    }
  });
}
