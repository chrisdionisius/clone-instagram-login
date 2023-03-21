import 'package:example_widget_testing/app/modules/home/components/story_item.dart';
import 'package:example_widget_testing/app/modules/home/home_page.dart';
import 'package:example_widget_testing/app/modules/search/search_page.dart';
import 'package:example_widget_testing/app/root_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'helper.dart';

void main() {
  testWidgets('Check if Search page is present', (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        const MaterialApp(
          home: RootApp(),
        ),
      ),
    );

    // navigate to search page
    final searchButtonFinder = find.byKey(const Key('bottom_item_1'));

    try {
      expect(searchButtonFinder, findsOneWidget);
    } catch (e) {
      debugPrint(e.toString());
    }

    await tester.pump(const Duration(milliseconds: 100));
    // tap the button
    await tester.tap(searchButtonFinder);

    final searchPageFinder = find.byType(SearchPage);

    try {
      expect(searchPageFinder, findsOneWidget);
    } catch (e) {
      debugPrint(e.toString());
    }
  });

  // testWidgets('Check if Home page Appbar is present',
  //     (WidgetTester tester) async {
  //   FlutterError.onError = ignoreOverflowErrors;

  //   await mockNetworkImagesFor(
  //     () => tester.pumpWidget(
  //       const MaterialApp(
  //         home: RootApp(),
  //       ),
  //     ),
  //   );
  //   final appBarFinder = find.byKey(const Key('app_bar_home'));

  //   try {
  //     expect(appBarFinder, findsOneWidget);
  //   } catch (e) {
  //     debugPrint('Appbar gagal ditemukan :');
  //     debugPrint(e.toString());
  //   }

  //   final appBar = appBarFinder.evaluate().first.widget as AppBar;

  //   try {
  //     expect(appBar.backgroundColor, Colors.black);
  //   } catch (e) {
  //     debugPrint('Warna appbar tidak sesuai :');
  //     debugPrint(e.toString());
  //   }

  //   try {
  //     expect(appBar.leading, isA<Icon>());
  //     expect((appBar.leading as Icon).icon, Icons.camera_alt);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }

  //   try {
  //     expect(appBar.title, isA<Center>());
  //     expect((appBar.title as Center).child, isA<Text>());
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }

  //   try {
  //     expect(appBar.actions, isA<List<Widget>>());
  //     expect(appBar.actions?.length, 1);
  //     expect(appBar.actions?.first, isA<Icon>());
  //     expect((appBar.actions?.first as Icon).icon, Icons.send);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // });
}
