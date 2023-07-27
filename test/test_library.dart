import 'package:flutter_test/flutter_test.dart';

void checkError(int index, dynamic expected, dynamic matcher) {
  expect(expected, matcher, reason: 'Error at test no. $index');
}

// checkByKeyFindOneWidget
void checkByTypeFindOneWidget(Finder finder) {
  const String trimString1 = 'zero widgets with type "';
  const String trimString2 = '" (ignoring offstage widgets)';

  final finderMessage =
      finder.toString().replaceAll(trimString1, '').replaceAll(trimString2, '');

  expect(finder, findsOneWidget,
      reason: "Penyebab: Widget $finderMessage Tidak ditemukan");
}

void checkByKeyFindOneWidget(Finder finder, String reason) {
  expect(finder, findsOneWidget, reason: reason);
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
void checkByKeyIsWidget(Finder finder, dynamic widget, String reason) {
  expect(finder.evaluate().first.widget, widget, reason: reason);
}
