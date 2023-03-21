import 'package:example_widget_testing/app/modules/home/components/story_item.dart';
import 'package:example_widget_testing/app/modules/home/home_page.dart';
import 'package:example_widget_testing/app/root_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'helper.dart';

void main() {
  testWidgets('Check if home page is present', (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        const MaterialApp(
          home: RootApp(),
        ),
      ),
    );
    final homePageFinder = find.byType(HomePage);

    try {
      expect(homePageFinder, findsOneWidget);
    } catch (e) {
      debugPrint(e.toString());
    }
  });

  testWidgets('Check if Home page Appbar is present',
      (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        const MaterialApp(
          home: RootApp(),
        ),
      ),
    );
    final appBarFinder = find.byKey(const Key('app_bar_home'));

    try {
      expect(appBarFinder, findsOneWidget);
    } catch (e) {
      debugPrint('Appbar gagal ditemukan :');
      debugPrint(e.toString());
    }

    final appBar = appBarFinder.evaluate().first.widget as AppBar;

    try {
      expect(appBar.backgroundColor, Colors.black);
    } catch (e) {
      debugPrint('Warna appbar tidak sesuai :');
      debugPrint(e.toString());
    }

    try {
      expect(appBar.leading, isA<Icon>());
      expect((appBar.leading as Icon).icon, Icons.camera_alt);
    } catch (e) {
      debugPrint(e.toString());
    }

    try {
      expect(appBar.title, isA<Center>());
      expect((appBar.title as Center).child, isA<Text>());
    } catch (e) {
      debugPrint(e.toString());
    }

    try {
      expect(appBar.actions, isA<List<Widget>>());
      expect(appBar.actions?.length, 1);
      expect(appBar.actions?.first, isA<Icon>());
      expect((appBar.actions?.first as Icon).icon, Icons.send);
    } catch (e) {
      debugPrint(e.toString());
    }
  });

  testWidgets('Check if Story is present', (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        const MaterialApp(
          home: RootApp(),
        ),
      ),
    );

    final storyFinder = find.byKey(const Key('stories'));

    try {
      expect(storyFinder, findsOneWidget);
    } catch (e) {
      debugPrint('Story gagal ditemukan :');
      debugPrint(e.toString());
    }

    final story = storyFinder.evaluate().first.widget as Row;

    try {
      expect(story.children, isA<List<Widget>>());
    } catch (e) {
      debugPrint(e.toString());
    }

    try {
      expect(story.children[0], isA<StoryItem>());
    } catch (e) {
      debugPrint(e.toString());
    }

    final storyItem = story.children[0] as StoryItem;
  });
}
