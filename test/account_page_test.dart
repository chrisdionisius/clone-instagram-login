import 'package:example_widget_testing/app/modules/account/account_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'helper.dart';

bool checkError(int index, dynamic expected, dynamic matcher) {
  try {
    expect(expected, matcher);
  } catch (e) {
    debugPrint('Account Page Test-$index failed:');
    debugPrint(e.toString());
    return false;
  }
  return true;
}

void main() {
  testWidgets('Check if Home page Appbar is present',
      (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        const MaterialApp(
          home: AccountPage(),
        ),
      ),
    );

    final appBarFinder = find.byKey(const Key('app_bar_account'));
    checkError(2, appBarFinder, findsOneWidget);

    final appBar = appBarFinder.evaluate().first.widget as AppBar;
    checkError(3, appBar.backgroundColor, Colors.black);
    checkError(4, appBar.automaticallyImplyLeading, false);
    final appBarRowFinder = find.byKey(const Key('app_bar_row'));
    if (checkError(5, appBarRowFinder, findsOneWidget)) {
      final appBarRow = appBarRowFinder.evaluate().first.widget as Row;
      checkError(
          6, appBarRow.mainAxisAlignment, MainAxisAlignment.spaceBetween);
      checkError(7, appBarRow.children.length, 2);

      final appBarRowNameFinder = find.byKey(const Key('app_bar_row_name'));
      if (checkError(
        8,
        find.descendant(of: appBarRowFinder, matching: appBarRowNameFinder),
        findsOneWidget,
      )) {
        final appBarRowName =
            appBarRowNameFinder.evaluate().first.widget as Row;
        checkError(9, appBarRowName.children.length, 2);

        final appBarRowNameTextFinder =
            find.byKey(const Key('app_bar_row_name_text'));
        if (checkError(
            10,
            find.descendant(
                of: appBarRowNameFinder, matching: appBarRowNameTextFinder),
            findsOneWidget)) {
          final appBarRowNameText =
              appBarRowNameTextFinder.evaluate().first.widget as Text;
          checkError(11, appBarRowNameText.data, 'iclop');
          checkError(12, appBarRowNameText.style!.fontWeight, FontWeight.bold);

          final appBarRowNameArrowDownIconFinder =
              find.byKey(const Key('app_bar_row_name_arrow_down_icon'));
          if (checkError(
              13,
              find.descendant(
                  of: appBarRowNameFinder,
                  matching: appBarRowNameArrowDownIconFinder),
              findsOneWidget)) {
            final appBarRowNameArrowDownIcon = appBarRowNameArrowDownIconFinder
                .evaluate()
                .first
                .widget as Icon;
            checkError(
                14, appBarRowNameArrowDownIcon.icon, Icons.keyboard_arrow_down);
          }
        }
      }

      final appBarRowMenuFinder = find.byKey(const Key('app_bar_row_menu'));
      bool appBarRowMenuIsAvailable = checkError(
          15,
          find.descendant(of: appBarRowFinder, matching: appBarRowMenuFinder),
          findsOneWidget);
      if (appBarRowMenuIsAvailable) {
        final appBarRowMenu =
            appBarRowMenuFinder.evaluate().first.widget as Row;
        checkError(16, appBarRowMenu.children.length, 3);

        final appBarRowMenuUploadIconFinder =
            find.byKey(const Key('app_bar_row_menu_upload_icon'));
        bool appBarRowMenuUploadIconIsAvailable = checkError(
            17,
            find.descendant(
                of: appBarRowMenuFinder,
                matching: appBarRowMenuUploadIconFinder),
            findsOneWidget);
        bool appBarRowMenuUploadIconIsSvgPicture = checkError(
            18,
            appBarRowMenuUploadIconFinder.evaluate().first.widget,
            isA<SvgPicture>());
        if (appBarRowMenuUploadIconIsAvailable &&
            appBarRowMenuUploadIconIsSvgPicture) {
          final appBarRowMenuUploadIcon = appBarRowMenuUploadIconFinder
              .evaluate()
              .first
              .widget as SvgPicture;
          checkError(19, appBarRowMenuUploadIcon.width, 27);
          bool appBarRowMenuUploadIconIsAssetPicture = checkError(
              20,
              appBarRowMenuUploadIcon.pictureProvider.runtimeType,
              ExactAssetPicture);
          if (appBarRowMenuUploadIconIsAssetPicture) {
            final appBarRowMenuUploadIconAssetPicture =
                appBarRowMenuUploadIcon.pictureProvider as ExactAssetPicture;
            checkError(21, appBarRowMenuUploadIconAssetPicture.assetName,
                "assets/images/upload_icon.svg");
          }
        }

        final appBarRowMenuHamburgerIconFinder =
            find.byKey(const Key('app_bar_row_menu_hamburger_icon'));
        bool appBarRowMenuHamburgerIconIsAvailable = checkError(
            22,
            find.descendant(
                of: appBarRowMenuFinder,
                matching: appBarRowMenuHamburgerIconFinder),
            findsOneWidget);
        bool appBarRowMenuHamburgerIconIsIcon = checkError(
            23,
            appBarRowMenuHamburgerIconFinder.evaluate().first.widget,
            isA<Icon>());
        if (appBarRowMenuHamburgerIconIsAvailable &&
            appBarRowMenuHamburgerIconIsIcon) {
          final appBarRowMenuHamburgerIcon =
              appBarRowMenuHamburgerIconFinder.evaluate().first.widget as Icon;
          checkError(24, appBarRowMenuHamburgerIcon.size, 35);
          checkError(25, appBarRowMenuHamburgerIcon.icon, Icons.menu);
        }
      }
    }
  });
}
