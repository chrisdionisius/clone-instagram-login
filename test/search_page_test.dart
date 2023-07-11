import 'package:example_widget_testing/app/modules/search/search_page.dart';
import 'package:example_widget_testing/app/widgets/post_thumbnail.dart';
import 'package:example_widget_testing/core/theme/colors.dart';
import 'package:example_widget_testing/core/values/constant/search_json.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'helper.dart';

void checkError(int index, dynamic expected, dynamic matcher) {
  try {
    expect(expected, matcher);
  } catch (e) {
    debugPrint('Searchpage Test-$index failed:');
    debugPrint(e.toString());
  }
}

void main() {
  testWidgets('Check if Search page is present', (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;
    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        MaterialApp(
          home: SearchPage(searchPosts: searchImages),
        ),
      ),
    );

    final searchPageListviewFinder = find.byKey(
      const Key('search_page_listview'),
    );
    checkError(
      1,
      searchPageListviewFinder,
      findsOneWidget,
    );
  });

  testWidgets('Check if search textfield is present',
      (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;
    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        MaterialApp(
          home: SearchPage(searchPosts: searchImages),
        ),
      ),
    );

    final searchPageListviewFinder = find.byKey(
      const Key('search_page_listview'),
    );

    final searchPageTextfieldContainerFinder = find.byKey(
      const Key('search_page_textfield_container'),
    );
    // mock screen size
    tester.binding.window.physicalSizeTestValue = const Size(375, 812);
    checkError(
        2,
        find.descendant(
          of: searchPageListviewFinder,
          matching: searchPageTextfieldContainerFinder,
        ),
        findsOneWidget);
    final searchPageTextfieldContainer = searchPageTextfieldContainerFinder
        .evaluate()
        .single
        .widget as Container;

    checkError(
      3,
      searchPageTextfieldContainer.margin,
      const EdgeInsets.only(
        bottom: 15,
        left: 15,
        right: 15,
      ),
    );

    checkError(4, searchPageTextfieldContainer.constraints!.maxHeight, 45.0);
    checkError(
      5,
      searchPageTextfieldContainer.decoration,
      isA<BoxDecoration>(),
    );

    final searchPageTextfieldContainerDecoration =
        searchPageTextfieldContainer.decoration as BoxDecoration;
    checkError(
      6,
      searchPageTextfieldContainerDecoration.borderRadius,
      const BorderRadius.all(Radius.circular(10)),
    );
    checkError(
      7,
      searchPageTextfieldContainerDecoration.color,
      const Color(0xff262626),
    );

    final searchPageTextfieldFinder = find.byKey(
      const Key('search_page_textfield'),
    );
    checkError(
      8,
      find.descendant(
        of: searchPageListviewFinder,
        matching: searchPageTextfieldFinder,
      ),
      findsOneWidget,
    );

    final searchPageTextfield =
        searchPageTextfieldFinder.evaluate().single.widget as TextField;
    checkError(9, searchPageTextfield.cursorColor, white.withOpacity(0.3));
    checkError(10, searchPageTextfield.style, isA<TextStyle>());

    final searchPageTextfieldStyle = searchPageTextfield.style as TextStyle;
    checkError(11, searchPageTextfieldStyle.color, white.withOpacity(0.3));

    checkError(12, searchPageTextfield.decoration, isA<InputDecoration>());

    final searchPageTextfieldDecoration =
        searchPageTextfield.decoration as InputDecoration;
    checkError(13, searchPageTextfieldDecoration.border, InputBorder.none);
    checkError(14, searchPageTextfieldDecoration.prefixIcon, isA<Icon>());

    final searchPageTextfieldPrefixIcon =
        searchPageTextfieldDecoration.prefixIcon as Icon;
    checkError(15, searchPageTextfieldPrefixIcon.icon, Icons.search);
    checkError(16, searchPageTextfieldPrefixIcon.color, white.withOpacity(0.3));

    final searchPageWrapFinder = find.byKey(
      const Key('search_page_wrap'),
    );
    checkError(
      17,
      find.descendant(
        of: searchPageListviewFinder,
        matching: searchPageWrapFinder,
      ),
      findsOneWidget,
    );

    final searchPageWrap =
        searchPageWrapFinder.evaluate().single.widget as Wrap;
    checkError(18, searchPageWrap.spacing, 1);
    checkError(19, searchPageWrap.runSpacing, 1);
    checkError(20, searchPageWrap.children.length, searchImages.length);
  });

  testWidgets('Check if search posts is present', (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;
    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        MaterialApp(
          home: SearchPage(searchPosts: searchImages),
        ),
      ),
    );

    final searchPageListviewFinder = find.byKey(
      const Key('search_page_listview'),
    );
    final searchPageWrapFinder = find.byKey(
      const Key('search_page_wrap'),
    );
    checkError(
      21,
      find.descendant(
        of: searchPageListviewFinder,
        matching: searchPageWrapFinder,
      ),
      findsOneWidget,
    );
    checkError(
      22,
      find.descendant(
        of: searchPageWrapFinder,
        matching: find.byType(Container),
      ),
      findsNWidgets(searchImages.length),
    );
  });

  testWidgets('Check if search posts thumbnail is present',
      (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;
    const String imageUrl = "https://picsum.photos/250?image=9";
    // mock screen size
    tester.binding.window.physicalSizeTestValue = const Size(375, 812);
    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        const MaterialApp(
          home: PostThumbnail(imageUrl: imageUrl),
        ),
      ),
    );

    final postThumbnailContainerFinder = find.byKey(
      const Key(imageUrl),
    );
    checkError(23, postThumbnailContainerFinder, findsOneWidget);

    final postThumbnailContainer =
        postThumbnailContainerFinder.evaluate().single.widget as Container;
    checkError(24, postThumbnailContainer.decoration, isA<BoxDecoration>());

    final postThumbnailContainerDecoration =
        postThumbnailContainer.decoration as BoxDecoration;
    checkError(
      25,
      postThumbnailContainerDecoration.image,
      isA<DecorationImage>(),
    );

    final postThumbnailContainerDecorationImage =
        postThumbnailContainerDecoration.image as DecorationImage;
    checkError(
      26,
      postThumbnailContainerDecorationImage.image,
      isA<NetworkImage>(),
    );
    checkError(
      27,
      postThumbnailContainerDecorationImage.fit,
      BoxFit.cover,
    );

    final postThumbnailContainerDecorationImageNetworkImage =
        postThumbnailContainerDecorationImage.image as NetworkImage;
    checkError(
      28,
      postThumbnailContainerDecorationImageNetworkImage.url,
      imageUrl,
    );
  });

  testWidgets('Check if Bottom Navbar is present', (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        MaterialApp(
          home: SearchPage(searchPosts: searchImages),
        ),
      ),
    );

    int pageIndex = 1;

    final bottomItem2Finder = find.byKey(
      const Key('bottom_item_1'),
    );
    checkError(29, bottomItem2Finder, findsOneWidget);

    await tester.ensureVisible(bottomItem2Finder);
    await tester.pumpAndSettle();
    await tester.tap(bottomItem2Finder);

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
    checkError(188, bottomNavigationBarContainer, findsOneWidget);

    final bottomNavigationBarContainerFinder =
        bottomNavigationBarContainer.evaluate().first.widget as Container;
    checkError(
        189, bottomNavigationBarContainerFinder.constraints!.maxHeight, 55);
    checkError(190, bottomNavigationBarContainerFinder.constraints!.maxWidth,
        double.infinity);
    checkError(191, bottomNavigationBarContainerFinder.color, black);
    checkError(192, bottomNavigationBarContainerFinder.padding,
        const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 15));

    final bottomNavigationBarRowFinder =
        find.byKey(const Key('bottom_navigation_bar_row'));
    checkError(
        193,
        find.descendant(
            of: bottomNavigationBarContainer,
            matching: bottomNavigationBarRowFinder),
        findsOneWidget);

    final bottomNavigationBarRow =
        bottomNavigationBarRowFinder.evaluate().first.widget as Row;
    checkError(194, bottomNavigationBarRow.mainAxisAlignment,
        MainAxisAlignment.spaceBetween);
    checkError(195, bottomNavigationBarRow.children, hasLength(5));

    bottomItems.asMap().forEach((index, value) {
      final bottomItem = bottomNavigationBarRow.children[index] as InkWell;
      checkError(196, bottomItem.onTap, isA<Function>());
      checkError(197, bottomItem.child, isA<SvgPicture>());

      final bottomItemSvgPicture = bottomItem.child as SvgPicture;
      checkError(198, bottomItemSvgPicture.pictureProvider.runtimeType,
          ExactAssetPicture);
      checkError(199, bottomItemSvgPicture.width, 27);
      final bottomItemSvgPicturePictureProvider =
          bottomItemSvgPicture.pictureProvider as ExactAssetPicture;
      checkError(200, bottomItemSvgPicturePictureProvider.assetName,
          bottomItems[index]);
    });
  });
}
