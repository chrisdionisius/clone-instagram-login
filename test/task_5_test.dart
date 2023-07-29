import 'package:example_widget_testing/app/modules/home/home_page.dart';
import 'package:example_widget_testing/core/theme/colors.dart';
import 'package:example_widget_testing/core/values/constant/post_json.dart';
import 'package:example_widget_testing/core/values/constant/profile_json.dart';
import 'package:example_widget_testing/core/values/constant/story_json.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'test_library.dart';

void main() {
  testWidgets('Check if Bottom Navbar is present', (WidgetTester tester) async {
    FlutterError.onError = customFlutterErrorHandler;

    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        MaterialApp(
          home: HomePage(
            posts: posts,
            profileData: profileJson,
            stories: stories,
          ),
        ),
      ),
    );

    int pageIndex = 0;

    List bottomItems = [
      pageIndex == 0
          ? "assets/images/home_active_icon.svg"
          : "assets/images/home_icon.svg",
      pageIndex == 1
          ? "assets/images/search_active_icon.svg"
          : "assets/images/search_icon.svg",
      pageIndex == 2
          ? "assets/images/upload_active_icon.svg"
          : "assets/images/upload_icon.svg",
      pageIndex == 3
          ? "assets/images/love_active_icon.svg"
          : "assets/images/love_icon.svg",
      pageIndex == 4
          ? "assets/images/account_active_icon.svg"
          : "assets/images/account_icon.svg",
    ];

    final bottomNavigationBarContainer =
        find.byKey(const Key('bottom_navigation_bar_container'));
    checkByKeyFindOneWidget(bottomNavigationBarContainer);

    final bottomNavigationBarContainerFinder =
        bottomNavigationBarContainer.evaluate().first.widget as Container;
    checkWidgetProperty(
      "maxHeight",
      bottomNavigationBarContainerFinder,
      bottomNavigationBarContainerFinder.constraints!.maxHeight,
      55,
    );
    checkWidgetProperty(
      "maxWidth",
      bottomNavigationBarContainerFinder,
      bottomNavigationBarContainerFinder.constraints!.maxWidth,
      double.infinity,
    );
    checkWidgetProperty(
      "color",
      bottomNavigationBarContainerFinder,
      bottomNavigationBarContainerFinder.color,
      black,
    );
    checkWidgetProperty(
      "padding",
      bottomNavigationBarContainerFinder,
      bottomNavigationBarContainerFinder.padding,
      const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 15),
    );

    final bottomNavigationBarRowFinder =
        find.byKey(const Key('bottom_navigation_bar_row'));
    checkWidgetDescendantProperty(
      bottomNavigationBarContainer,
      bottomNavigationBarRowFinder,
    );

    final bottomNavigationBarRow =
        bottomNavigationBarRowFinder.evaluate().first.widget as Row;
    checkWidgetProperty(
      "mainAxisAlignment",
      bottomNavigationBarRow,
      bottomNavigationBarRow.mainAxisAlignment,
      MainAxisAlignment.spaceBetween,
    );
    // checkError(195, bottomNavigationBarRow.children, hasLength(5));

    bottomItems.asMap().forEach((index, value) {
      final bottomItem = bottomNavigationBarRow.children[index] as InkWell;
      checkByKeyIsWidget(bottomItem.onTap, isA<Function>());
      checkByKeyIsWidget(bottomItem.child, isA<SvgPicture>());

      final bottomItemSvgPicture = bottomItem.child as SvgPicture;
      checkWidgetProperty(
        "runtimeType",
        bottomItemSvgPicture.pictureProvider,
        bottomItemSvgPicture.pictureProvider.runtimeType,
        ExactAssetPicture,
      );
      checkWidgetProperty(
        "width",
        bottomItemSvgPicture,
        bottomItemSvgPicture.width,
        27,
      );

      final bottomItemSvgPicturePictureProvider =
          bottomItemSvgPicture.pictureProvider as ExactAssetPicture;
      checkWidgetProperty(
        "assetName",
        bottomItemSvgPicturePictureProvider,
        bottomItemSvgPicturePictureProvider.assetName,
        bottomItems[index],
      );
    });
  });
}
