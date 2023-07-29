import 'package:example_widget_testing/app/modules/home/components/story_item.dart';
import 'package:example_widget_testing/app/modules/home/home_page.dart';
import 'package:example_widget_testing/core/values/constant/profile_json.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:example_widget_testing/core/values/constant/story_json.dart';
import 'package:example_widget_testing/core/theme/colors.dart';
import 'package:example_widget_testing/core/values/constant/post_json.dart';
import 'test_library.dart';

void main() {
  testWidgets('Check if home page is present', (WidgetTester tester) async {
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
    final homePageFinder = find.byType(HomePage);
    checkByTypeFindOneWidget(homePageFinder);
  });

  testWidgets('Check if Home page Appbar is present',
      (WidgetTester tester) async {
    FlutterError.onError = customFlutterErrorHandler;
    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        MaterialApp(
          home: HomePage(
              posts: posts, profileData: profileJson, stories: stories),
        ),
      ),
    );

    final appBarFinder = find.byKey(const Key('home_page_appbar'));
    checkByKeyFindOneWidget(appBarFinder);

    final appBar = appBarFinder.evaluate().first.widget as AppBar;
    checkWidgetProperty(
        "backgroundColor", appBar, appBar.backgroundColor, Colors.black);
    checkByKeyIsWidget(appBar.leading, isA<Icon>());

    final appBarLeading = appBar.leading as Icon;
    checkWidgetProperty("icon", appBar, appBarLeading.icon, Icons.camera_alt);
    checkByKeyIsWidget(appBar.title, isA<Center>());

    final appBarTitle = appBar.title as Center;
    checkByKeyIsWidget(appBarTitle.child, isA<Text>());
    checkByKeyIsWidget(appBar.actions, isA<List<Widget>>());
    // checkError(9, appBar.actions?.length, 1);

    final appBarAction = appBar.actions?.first as Icon;
    checkWidgetProperty("icon", appBar, appBarAction.icon, Icons.send);
  });

  testWidgets('Check if Story is present', (WidgetTester tester) async {
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

    final storyFinder = find.byKey(const Key('following_stories_row'));
    checkByKeyFindOneWidget(storyFinder);

    final story = storyFinder.evaluate().first.widget as Row;
    checkByKeyIsWidget(story.children, isA<List<Widget>>());
    checkWidgetProperty(
        "length", storyFinder, story.children.length, stories.length);
    checkByKeyIsWidget(story.children[0], isA<StoryItem>());

    stories.asMap().forEach((index, value) {
      final storyItem = story.children[index] as StoryItem;
      checkWidgetProperty("name", storyFinder, storyItem.name, value['name']);
      checkWidgetProperty("img", storyFinder, storyItem.img, value['img']);
    });
  });

  testWidgets('Check if StoryItem rendered correctly',
      (WidgetTester tester) async {
    // Define test data
    const String imageUrl = 'https://example.com/image.jpg';
    const String name = 'John Doe';

    FlutterError.onError = customFlutterErrorHandler;

    await mockNetworkImagesFor(() => tester.pumpWidget(
        const MaterialApp(home: StoryItem(img: imageUrl, name: name))));

    // checkError(17, find.byType(Container), findsNWidgets(2));

    final storyItemPaddingFinder = find.byKey(const Key('story_item_padding'));
    checkByKeyFindOneWidget(storyItemPaddingFinder);

    final storyItemPadding =
        storyItemPaddingFinder.evaluate().first.widget as Padding;
    checkWidgetProperty(
      "padding",
      storyItemPaddingFinder,
      storyItemPadding.padding,
      const EdgeInsets.only(right: 20, bottom: 10),
    );

    final storyItemColumnFinder = find.byKey(const Key('story_item_column'));
    checkByKeyFindOneWidget(storyItemColumnFinder);
    checkWidgetDescendantProperty(
        storyItemPaddingFinder, storyItemColumnFinder);

    final storyItemColumn =
        storyItemColumnFinder.evaluate().first.widget as Column;
    checkByKeyIsWidget(storyItemColumn.children, isA<List<Widget>>());
    // checkError(23, storyItemColumn.children.length, 2);

    final storyItemContainerFinder = find.byKey(
      const Key('story_item_container'),
    );
    checkWidgetDescendantProperty(
        storyItemColumnFinder, storyItemContainerFinder);

    final storyItemContainer =
        storyItemContainerFinder.evaluate().first.widget as Container;

    checkWidgetProperty(
      "width",
      storyItemContainerFinder,
      storyItemContainer.constraints!.widthConstraints(),
      const BoxConstraints(minWidth: 68, maxWidth: 68),
    );

    checkWidgetProperty(
      "margin",
      storyItemContainerFinder,
      storyItemContainer.margin,
      const EdgeInsets.only(bottom: 8),
    );

    checkWidgetProperty(
      "height",
      storyItemContainerFinder,
      storyItemContainer.constraints!.heightConstraints(),
      const BoxConstraints(minHeight: 68, maxHeight: 68),
    );

    checkByKeyIsWidget(storyItemContainer.decoration, isA<BoxDecoration>());

    final storyItemContainerDecoration =
        storyItemContainer.decoration as BoxDecoration;
    checkWidgetProperty(
      "shape",
      storyItemContainerFinder,
      storyItemContainerDecoration.shape,
      BoxShape.circle,
    );

    checkByKeyIsWidget(
        storyItemContainerDecoration.gradient, isA<LinearGradient>());
    final storyItemContainerGradient =
        storyItemContainerDecoration.gradient as LinearGradient;
    checkWidgetProperty(
      "begin",
      storyItemContainerFinder,
      storyItemContainerGradient.begin,
      Alignment.topCenter,
    );
    checkWidgetProperty(
      'end',
      storyItemContainerFinder,
      storyItemContainerGradient.end,
      Alignment.bottomCenter,
    );
    checkWidgetProperty(
      "colors",
      storyItemContainerFinder,
      storyItemContainerGradient.colors,
      const <Color>[Color(0xFF9B2282), Color(0xFFEEA863)],
    );

    final storyItemImageContainerFinder = find.byKey(
      const Key('story_item_image_container'),
    );

    checkWidgetDescendantProperty(
        storyItemContainerFinder, storyItemImageContainerFinder);

    final storyItemImageContainer =
        storyItemImageContainerFinder.evaluate().first.widget as Container;

    checkWidgetProperty(
      "width",
      storyItemImageContainerFinder,
      storyItemImageContainer.constraints!.widthConstraints(),
      const BoxConstraints(minWidth: 65, maxWidth: 65),
    );

    checkWidgetProperty(
      "height",
      storyItemImageContainerFinder,
      storyItemImageContainer.constraints!.heightConstraints(),
      const BoxConstraints(minHeight: 65, maxHeight: 65),
    );

    checkWidgetProperty(
      "margin",
      storyItemImageContainerFinder,
      storyItemImageContainer.margin,
      const EdgeInsets.all(3),
    );

    checkByKeyIsWidget(
        storyItemImageContainer.decoration, isA<BoxDecoration>());

    final storyItemImageContainerDecoration =
        storyItemImageContainer.decoration as BoxDecoration;
    checkWidgetProperty(
      "shape",
      storyItemImageContainerFinder,
      storyItemImageContainerDecoration.shape,
      BoxShape.circle,
    );
    checkWidgetProperty(
      "border",
      storyItemImageContainerFinder,
      storyItemImageContainerDecoration.border,
      const Border.fromBorderSide(
        BorderSide(
          color: black,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
    );

    checkByKeyIsWidget(
        storyItemImageContainerDecoration.image, isA<DecorationImage>());

    final storyItemImageContainerDecorationImage =
        (storyItemImageContainer.decoration as BoxDecoration).image
            as DecorationImage;
    checkByKeyIsWidget(
        storyItemImageContainerDecorationImage.image, isA<NetworkImage>());

    checkWidgetProperty(
      "fit",
      storyItemImageContainerFinder,
      storyItemImageContainerDecorationImage.fit,
      BoxFit.cover,
    );

    final storyItemUsernameSizeBoxFinder = find.byKey(
      const Key('story_item_username_sizedbox'),
    );

    checkWidgetDescendantProperty(
        storyItemColumnFinder, storyItemUsernameSizeBoxFinder);

    final storyItemUsernameSizeBox =
        storyItemUsernameSizeBoxFinder.evaluate().first.widget as SizedBox;
    checkWidgetProperty(
      "width",
      storyItemUsernameSizeBoxFinder,
      storyItemUsernameSizeBox.width,
      70,
    );

    final storyItemUsernameTextFinder = find.byKey(
      const Key('story_item_username_text'),
    );

    checkWidgetDescendantProperty(
        storyItemUsernameSizeBoxFinder, storyItemUsernameTextFinder);

    final storyItemUsernameText =
        storyItemUsernameTextFinder.evaluate().first.widget as Text;
    checkWidgetProperty(
      "data",
      storyItemUsernameTextFinder,
      storyItemUsernameText.data,
      name,
    );
    checkWidgetProperty(
      "overflow",
      storyItemUsernameTextFinder,
      storyItemUsernameText.overflow,
      TextOverflow.ellipsis,
    );
    checkWidgetProperty(
      "color",
      storyItemUsernameTextFinder,
      storyItemUsernameText.style!.color,
      white,
    );
  });

  testWidgets('Check if divider is present', (WidgetTester tester) async {
    FlutterError.onError = customFlutterErrorHandler;

    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(
          posts: posts,
          profileData: profileJson,
          stories: stories,
        ),
      ),
    );

    final dividerFinder = find.byKey(const Key('home_page_divider'));
    checkByKeyFindOneWidget(dividerFinder);

    final divider = dividerFinder.evaluate().first.widget as Divider;
    checkWidgetProperty(
      "color",
      dividerFinder,
      divider.color,
      white.withOpacity(0.3),
    );
  });
}
