import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const String divider = '======================================================';

String keyRetriever(String source) {
  String key = source;

  int keyIndexBegin = source.indexOf("[<'");
  int keyIndexEnd = source.indexOf("'>]");

  if (keyIndexBegin != -1 &&
      keyIndexEnd != -1 &&
      keyIndexEnd != -1 &&
      keyIndexEnd > keyIndexBegin + 3) {
    key = source.substring(keyIndexBegin + 3, keyIndexEnd);
  }

  return key;
}

void customFlutterErrorHandler(FlutterErrorDetails details) {
  if (details.exception is FlutterError &&
      details.exception.toString().contains('overflow')) {
    return;
  }

  debugPrint(
      'Terdapat error pada kode program anda\n${details.exceptionAsString()}');

  FlutterError.presentError(details);
  throw details.exception;
}

void checkError(int index, dynamic expected, dynamic matcher) {
  expect(expected, matcher, reason: 'Error at test no. $index');
}

// checkByTypeFindOneWidget
void checkByTypeFindOneWidget(Finder finder) {
  const String trimString1 = 'zero widgets with type "';
  const String trimString2 = '" (ignoring offstage widgets)';

  final finderMessage =
      finder.toString().replaceAll(trimString1, '').replaceAll(trimString2, '');

  expect(finder, findsOneWidget,
      reason: "Penyebab: Widget $finderMessage Tidak ditemukan\n$divider");
}

void checkByTypeFindNWidget(Finder finder, int n) {
  expect(finder, findsNWidgets(n),
      reason: "Penyebab: Widget $finder Tidak ditemukan\n$divider");
}

// checkByKeyFindOneWidget
void checkByKeyFindOneWidget(Finder finder) {
  const String trimString1 = "zero widgets with key [<'";
  const String trimString2 = "'>] (ignoring offstage widgets)";

  final finderMessage =
      finder.toString().replaceAll(trimString1, '').replaceAll(trimString2, '');

  expect(finder, findsOneWidget,
      reason:
          "Penyebab: Widget dengan key '$finderMessage' tidak ditemukan, pastikan sudah menambahkan key pada widget dan pastikan key pada kode program sesuai dengan guide\n$divider");
}

// checkByKeyFindNWidget
void checkByKeyFindNWidget(Finder finder, int n, String reason) {
  expect(finder, findsNWidgets(n), reason: reason);
}

// checkByKeyFindNothing
void checkByKeyFindNothing(Finder finder, String reason) {
  expect(finder, findsNothing, reason: reason);
}

// checkFindTextOneWidget
void checkFindTextOneWidget(String text, String reason) {
  expect(find.text(text), findsOneWidget, reason: reason);
}

// checkFindTextNWidget
void checkFindTextNWidget(String text, int n, String reason) {
  expect(find.text(text), findsNWidgets(n), reason: reason);
}

// checkFindTextNothing
void checkFindTextNothing(String text, String reason) {
  expect(find.text(text), findsNothing, reason: reason);
}

// checkByKeyIsWidget
void checkByKeyIsWidget(dynamic finder, dynamic matcher) {
  const matcherString1 = "Instance of 'TypeMatcher<";
  const matcherString2 = ">'";
  final matcherString = matcher
      .toString()
      .replaceAll(matcherString1, '')
      .replaceAll(matcherString2, '');

  String trimmedFinder = finder.toString();

  var index = finder.toString().indexOf("-[<");
  if (index != -1) {
    trimmedFinder = finder.toString().substring(0, index);
  }

  String key = keyRetriever(finder.toString());

  expect(finder, matcher,
      reason:
          "Penyebab: Widget yang seharusnya adalah : '$matcherString', namun ditemukan widget dengan tipe: '$trimmedFinder' untuk widget dengan key: '$key'\n$divider");
}

// checkWidgetProperty
void checkWidgetProperty(String property, dynamic finderWidget,
    dynamic propertyValue, dynamic matcher) {
  String key = keyRetriever(finderWidget.toString());

  expect(propertyValue, matcher,
      reason:
          "Penyebab: Widget dengan key '$key' seharusnya memiliki properti $property dengan nilai '$matcher', namun nilai yang ditemukan adalah '$propertyValue'\n$divider");
}

// checkWidgetDecendantProperty
void checkWidgetDescendantProperty(dynamic parent, dynamic finder) {
  String finderKey = keyRetriever(finder.toString());
  String parentKey = keyRetriever(parent.toString());
  expect(
    find.descendant(of: parent, matching: finder),
    findsOneWidget,
    reason:
        "Penyebab: Pada widget dengan key '$parentKey' Tidak ditemukan child widget dengan key '$finderKey'",
  );
}
