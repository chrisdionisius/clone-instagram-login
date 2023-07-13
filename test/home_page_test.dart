import 'package:example_widget_testing/app/modules/home/components/story_item.dart';
import 'package:example_widget_testing/app/modules/home/home_page.dart';
import 'package:example_widget_testing/app/widgets/post_item.dart';
import 'package:example_widget_testing/core/values/constant/profile_json.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
// import story_json.dart'
import 'package:example_widget_testing/core/values/constant/story_json.dart';
import 'package:example_widget_testing/core/theme/colors.dart';
import 'package:example_widget_testing/core/values/constant/post_json.dart';

import 'helper.dart';

void checkError(int index, dynamic expected, dynamic matcher) {
  try {
    expect(expected, matcher);
  } catch (e) {
    debugPrint('Homepage Test-$index failed:');
    debugPrint(e.toString());
  }
}

void main() {
  testWidgets('Check if home page is present', (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        MaterialApp(
          home: HomePage(
              posts: posts, profileData: profileJson, stories: stories),
        ),
      ),
    );
    final homePageFinder = find.byType(HomePage);
    checkError(1, homePageFinder, findsOneWidget);
  });

  testWidgets('Check if Home page Appbar is present',
      (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        MaterialApp(
          home: HomePage(
              posts: posts, profileData: profileJson, stories: stories),
        ),
      ),
    );

    final appBarFinder = find.byKey(const Key('home_page_appbar'));
    checkError(2, appBarFinder, findsOneWidget);

    final appBar = appBarFinder.evaluate().first.widget as AppBar;
    checkError(3, appBar.backgroundColor, Colors.black);
    checkError(4, appBar.leading, isA<Icon>());

    final appBarLeading = appBar.leading as Icon;
    checkError(5, appBarLeading.icon, Icons.camera_alt);
    checkError(6, appBar.title, isA<Center>());

    final appBarTitle = appBar.title as Center;
    checkError(7, appBarTitle.child, isA<Text>());
    checkError(8, appBar.actions, isA<List<Widget>>());
    checkError(9, appBar.actions?.length, 1);

    final appBarAction = appBar.actions?.first as Icon;
    checkError(10, appBarAction.icon, Icons.send);
  });

  testWidgets('Check if Story is present', (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        MaterialApp(
          home: HomePage(
              posts: posts, profileData: profileJson, stories: stories),
        ),
      ),
    );

    final storyFinder = find.byKey(const Key('following_stories_row'));
    checkError(11, storyFinder, findsOneWidget);

    final story = storyFinder.evaluate().first.widget as Row;
    checkError(12, story.children, isA<List<Widget>>());
    checkError(13, story.children.length, stories.length);
    checkError(14, story.children[0], isA<StoryItem>());

    stories.asMap().forEach((index, value) {
      final storyItem = story.children[index] as StoryItem;
      checkError(15, storyItem.name, value['name']);
      checkError(16, storyItem.img, value['img']);
    });
  });

  testWidgets('Check if StoryItem rendered correctly',
      (WidgetTester tester) async {
    // Define test data
    const String imageUrl = 'https://example.com/image.jpg';
    const String name = 'John Doe';

    await mockNetworkImagesFor(() => tester.pumpWidget(
        const MaterialApp(home: StoryItem(img: imageUrl, name: name))));

    checkError(17, find.byType(Container), findsNWidgets(2));

    final storyItemPaddingFinder = find.byKey(const Key('story_item_padding'));
    checkError(18, storyItemPaddingFinder, findsOneWidget);

    final storyItemPadding =
        storyItemPaddingFinder.evaluate().first.widget as Padding;
    checkError(
      19,
      storyItemPadding.padding,
      const EdgeInsets.only(right: 20, bottom: 10),
    );

    final storyItemColumnFinder = find.byKey(const Key('story_item_column'));
    checkError(20, storyItemColumnFinder, findsOneWidget);
    checkError(
      21,
      find.descendant(
          of: storyItemPaddingFinder, matching: storyItemColumnFinder),
      findsOneWidget,
    );

    final storyItemColumn =
        storyItemColumnFinder.evaluate().first.widget as Column;
    checkError(22, storyItemColumn.children, isA<List<Widget>>());
    checkError(23, storyItemColumn.children.length, 2);

    final storyItemContainerFinder = find.byKey(
      const Key('story_item_container'),
    );
    checkError(
      24,
      find.descendant(
        of: storyItemColumnFinder,
        matching: storyItemContainerFinder,
      ),
      findsOneWidget,
    );

    final storyItemContainer =
        storyItemContainerFinder.evaluate().first.widget as Container;

    checkError(
      25,
      storyItemContainer.constraints!.widthConstraints(),
      const BoxConstraints(minWidth: 68, maxWidth: 68),
    );

    checkError(26, storyItemContainer.margin, const EdgeInsets.only(bottom: 8));

    checkError(
      27,
      storyItemContainer.constraints!.heightConstraints(),
      const BoxConstraints(minHeight: 68, maxHeight: 68),
    );

    checkError(29, storyItemContainer.decoration, isA<BoxDecoration>());

    final storyItemContainerDecoration =
        storyItemContainer.decoration as BoxDecoration;
    checkError(28, storyItemContainerDecoration.shape, BoxShape.circle);

    checkError(
        30, storyItemContainerDecoration.gradient, isA<LinearGradient>());
    final storyItemContainerGradient =
        storyItemContainerDecoration.gradient as LinearGradient;
    checkError(31, storyItemContainerGradient.begin, Alignment.topCenter);
    checkError(32, storyItemContainerGradient.end, Alignment.bottomCenter);
    checkError(33, storyItemContainerGradient.colors,
        const <Color>[Color(0xFF9B2282), Color(0xFFEEA863)]);

    final storyItemImageContainerFinder = find.byKey(
      const Key('story_item_image_container'),
    );

    checkError(
      34,
      find.descendant(
        of: storyItemContainerFinder,
        matching: storyItemImageContainerFinder,
      ),
      findsOneWidget,
    );

    final storyItemImageContainer =
        storyItemImageContainerFinder.evaluate().first.widget as Container;

    checkError(
      35,
      storyItemImageContainer.constraints!.widthConstraints(),
      const BoxConstraints(minWidth: 65, maxWidth: 65),
    );

    checkError(
      36,
      storyItemImageContainer.constraints!.heightConstraints(),
      const BoxConstraints(minHeight: 65, maxHeight: 65),
    );

    checkError(37, storyItemImageContainer.margin, const EdgeInsets.all(3));
    checkError(38, storyItemImageContainer.decoration, isA<BoxDecoration>());

    final storyItemImageContainerDecoration =
        storyItemImageContainer.decoration as BoxDecoration;
    checkError(39, storyItemImageContainerDecoration.shape, BoxShape.circle);
    checkError(
      40,
      storyItemImageContainerDecoration.border,
      const Border.fromBorderSide(
        BorderSide(
          color: black,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
    );

    checkError(
        41, storyItemImageContainerDecoration.image, isA<DecorationImage>());

    final storyItemImageContainerDecorationImage =
        (storyItemImageContainer.decoration as BoxDecoration).image
            as DecorationImage;
    checkError(
        42, storyItemImageContainerDecorationImage.image, isA<NetworkImage>());

    checkError(42, storyItemImageContainerDecorationImage.fit, BoxFit.cover);

    final storyItemUsernameSizeBoxFinder = find.byKey(
      const Key('story_item_username_sizedbox'),
    );

    checkError(
      43,
      find.descendant(
          of: storyItemColumnFinder, matching: storyItemUsernameSizeBoxFinder),
      findsOneWidget,
    );

    final storyItemUsernameSizeBox =
        storyItemUsernameSizeBoxFinder.evaluate().first.widget as SizedBox;
    checkError(44, storyItemUsernameSizeBox.width, 70);

    final storyItemUsernameTextFinder = find.byKey(
      const Key('story_item_username_text'),
    );

    checkError(
      45,
      find.descendant(
          of: storyItemUsernameSizeBoxFinder,
          matching: storyItemUsernameTextFinder),
      findsOneWidget,
    );

    final storyItemUsernameText =
        storyItemUsernameTextFinder.evaluate().first.widget as Text;
    checkError(46, storyItemUsernameText.data, name);
    checkError(47, storyItemUsernameText.overflow, TextOverflow.ellipsis);
    checkError(48, storyItemUsernameText.style!.color, white);
  });

  testWidgets('Check if divider is present', (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await tester.pumpWidget(
      MaterialApp(
        home:
            HomePage(posts: posts, profileData: profileJson, stories: stories),
      ),
    );

    final dividerFinder = find.byKey(const Key('home_page_divider'));
    checkError(49, dividerFinder, findsOneWidget);

    final divider = dividerFinder.evaluate().first.widget as Divider;
    checkError(50, divider.color, white.withOpacity(0.3));
  });

  testWidgets('Check if Posts Column is present', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home:
            HomePage(posts: posts, profileData: profileJson, stories: stories),
      ),
    );

    final homePageColumnFinder = find.byKey(const Key('home_page_column'));

    final postsColumnFinder = find.byKey(const Key('posts_column'));

    checkError(
      51,
      find.descendant(of: homePageColumnFinder, matching: postsColumnFinder),
      findsOneWidget,
    );
    checkError(52, postsColumnFinder, findsOneWidget);

    final postsColumn = postsColumnFinder.evaluate().first.widget as Column;
    checkError(53, postsColumn.children.length, posts.length);
  });

  testWidgets(
    'Check if PostItem rendered correctly',
    (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;

      await mockNetworkImagesFor(
        () => tester.pumpWidget(
          MaterialApp(
            home: PostItem(
              postImg: posts[0]['postImg'],
              profileImg: posts[0]['profileImg'],
              name: posts[0]['name'],
              caption: posts[0]['caption'],
              isLoved: posts[0]['isLoved'],
              viewCount: posts[0]['commentCount'],
              likedBy: posts[0]['likedBy'],
              dayAgo: posts[0]['timeAgo'],
              userPhoto: profile,
            ),
          ),
        ),
      );

      final postItemPaddingFinder = find.byKey(const Key('post_item_padding'));
      checkError(54, postItemPaddingFinder, findsOneWidget);

      final postItemPadding =
          postItemPaddingFinder.evaluate().first.widget as Padding;
      checkError(
          55, postItemPadding.padding, const EdgeInsets.only(bottom: 10));

      final postItemColumnFinder = find.byKey(const Key('post_item_column'));
      checkError(
        56,
        find.descendant(
            of: postItemPaddingFinder, matching: postItemColumnFinder),
        findsOneWidget,
      );

      final postItemColumn =
          postItemColumnFinder.evaluate().first.widget as Column;
      checkError(
          57, postItemColumn.crossAxisAlignment, CrossAxisAlignment.start);
      checkError(58, postItemColumn.children.length, 8);

      final postItemUserInfoContainerFinder = find.byKey(
        const Key('post_item_user_info_container'),
      );

      checkError(
        59,
        find.descendant(
            of: postItemColumnFinder,
            matching: postItemUserInfoContainerFinder),
        findsOneWidget,
      );

      final postItemUserInfoContainer =
          postItemUserInfoContainerFinder.evaluate().first.widget as Container;

      checkError(60, postItemUserInfoContainer.padding,
          const EdgeInsets.symmetric(vertical: 10, horizontal: 15));

      checkError(61, postItemUserInfoContainer.margin,
          const EdgeInsets.only(bottom: 12));

      final postItemUserInfoRowFinder = find.byKey(
        const Key('post_item_user_info_row'),
      );
      checkError(
        62,
        find.descendant(
            of: postItemUserInfoContainerFinder,
            matching: postItemUserInfoRowFinder),
        findsOneWidget,
      );

      final postItemUserInfoRow =
          postItemUserInfoRowFinder.evaluate().first.widget as Row;

      checkError(63, postItemUserInfoRow.mainAxisAlignment,
          MainAxisAlignment.spaceBetween);
      checkError(64, postItemUserInfoRow.children.length, 3);

      final postItemUserImgContainerFinder = find.byKey(
        const Key('post_item_user_profile_img_container'),
      );

      checkError(
        65,
        find.descendant(
            of: postItemUserInfoRowFinder,
            matching: postItemUserImgContainerFinder),
        findsOneWidget,
      );

      final postItemUserImgContainer =
          postItemUserImgContainerFinder.evaluate().first.widget as Container;

      checkError(66, postItemUserImgContainer.constraints!.widthConstraints(),
          const BoxConstraints(minWidth: 40, maxWidth: 40));
      checkError(67, postItemUserImgContainer.constraints!.heightConstraints(),
          const BoxConstraints(minHeight: 40, maxHeight: 40));
      checkError(68, postItemUserImgContainer.margin,
          const EdgeInsets.only(right: 15));
      checkError(69, postItemUserImgContainer.decoration, isA<BoxDecoration>());

      final postItemUserImgContainerDecoration =
          postItemUserImgContainer.decoration as BoxDecoration;
      checkError(70, postItemUserImgContainerDecoration.shape, BoxShape.circle);
      checkError(
          71, postItemUserImgContainerDecoration.image, isA<DecorationImage>());

      final postItemUserImgContainerDecorationImage =
          postItemUserImgContainerDecoration.image as DecorationImage;
      checkError(72, postItemUserImgContainerDecorationImage.image,
          isA<NetworkImage>());
      checkError(73, postItemUserImgContainerDecorationImage.fit, BoxFit.cover);

      final postItemUserImgContainerDecorationImageNetworkImage =
          postItemUserImgContainerDecorationImage.image as NetworkImage;
      checkError(74, postItemUserImgContainerDecorationImageNetworkImage.url,
          posts[0]['profileImg']);

      final postItemUserNameExpendedFinder = find.byKey(
        const Key('post_item_user_name_expanded'),
      );

      checkError(
        75,
        find.descendant(
            of: postItemUserInfoRowFinder,
            matching: postItemUserNameExpendedFinder),
        findsOneWidget,
      );

      final postItemUserNameTextFinder = find.byKey(
        const Key('post_item_user_name_text'),
      );

      checkError(
        76,
        find.descendant(
            of: postItemUserNameExpendedFinder,
            matching: postItemUserNameTextFinder),
        findsOneWidget,
      );

      final postItemUserNameText =
          postItemUserNameTextFinder.evaluate().first.widget as Text;
      checkError(77, postItemUserNameText.data, posts[0]['name']);
      checkError(78, postItemUserNameText.style, isA<TextStyle>());
      final postItemUserNameTextStyle = postItemUserNameText.style as TextStyle;
      checkError(79, postItemUserNameTextStyle.color, Colors.white);
      checkError(80, postItemUserNameTextStyle.fontWeight, FontWeight.w500);
      checkError(81, postItemUserNameTextStyle.fontSize, 15);

      final postItemUserMoreIconFinder = find.byKey(
        const Key('post_item_user_more_icon'),
      );

      checkError(
        82,
        find.descendant(
            of: postItemUserInfoRowFinder,
            matching: postItemUserMoreIconFinder),
        findsOneWidget,
      );

      final postItemUserMoreIcon =
          postItemUserMoreIconFinder.evaluate().first.widget as Icon;
      checkError(83, postItemUserMoreIcon.icon, Icons.more_horiz);
      checkError(84, postItemUserMoreIcon.color, Colors.white);

      final postItemImageContainerFinder = find.byKey(
        const Key('post_item_image_container'),
      );
      checkError(
        85,
        find.descendant(
            of: postItemColumnFinder, matching: postItemImageContainerFinder),
        findsOneWidget,
      );

      final postItemImageContainer =
          postItemImageContainerFinder.evaluate().first.widget as Container;
      checkError(86, postItemImageContainer.constraints!.heightConstraints(),
          const BoxConstraints(maxHeight: 400, minHeight: 400));
      checkError(
          87, postItemImageContainer.margin, const EdgeInsets.only(bottom: 10));
      checkError(88, postItemImageContainer.decoration, isA<BoxDecoration>());

      final postItemImageContainerDecoration =
          postItemImageContainer.decoration as BoxDecoration;
      checkError(
          89, postItemImageContainerDecoration.image, isA<DecorationImage>());

      final postItemImageContainerDecorationImage =
          postItemImageContainerDecoration.image as DecorationImage;
      checkError(
          90, postItemImageContainerDecorationImage.image, isA<NetworkImage>());
      checkError(91, postItemImageContainerDecorationImage.fit, BoxFit.cover);

      final postItemImageContainerDecorationImageNetworkImage =
          postItemImageContainerDecorationImage.image as NetworkImage;
      checkError(92, postItemImageContainerDecorationImageNetworkImage.url,
          posts[0]['postImg']);

      final postItemActionContainerFinder =
          find.byKey(const Key('post_item_actions_container'));
      checkError(
        93,
        find.descendant(
            of: postItemColumnFinder, matching: postItemActionContainerFinder),
        findsOneWidget,
      );

      final postItemActionContainer =
          postItemActionContainerFinder.evaluate().first.widget as Container;
      checkError(
        94,
        postItemActionContainer.padding,
        const EdgeInsets.fromLTRB(15, 3, 15, 0),
      );
      checkError(95, postItemActionContainer.margin,
          const EdgeInsets.only(bottom: 12));

      final postItemActionRowFinder = find.byKey(
        const Key('post_item_actions_row'),
      );
      checkError(
        96,
        find.descendant(
            of: postItemActionContainerFinder,
            matching: postItemActionRowFinder),
        findsOneWidget,
      );

      final postItemActionRow =
          postItemActionRowFinder.evaluate().first.widget as Row;
      checkError(97, postItemActionRow.mainAxisAlignment,
          MainAxisAlignment.spaceBetween);
      checkError(98, postItemActionRow.children.length, 2);

      final postItemActionsLeftRowFinder = find.byKey(
        const Key('post_item_actions_left_row'),
      );
      checkError(
        99,
        find.descendant(
            of: postItemActionRowFinder,
            matching: postItemActionsLeftRowFinder),
        findsOneWidget,
      );

      final postItemActionsLeftRow =
          postItemActionsLeftRowFinder.evaluate().first.widget as Row;
      checkError(100, postItemActionsLeftRow.children.length, 5);

      final postItemActionsLoveIconFinder = find.byKey(
        const Key('post_item_actions_love_icon'),
      );
      checkError(
        101,
        find.descendant(
            of: postItemActionsLeftRowFinder,
            matching: postItemActionsLoveIconFinder),
        findsOneWidget,
      );

      final postItemActionsLoveIcon =
          postItemActionsLoveIconFinder.evaluate().first.widget as SvgPicture;
      checkError(102, postItemActionsLoveIcon, isA<SvgPicture>());
      checkError(103, postItemActionsLoveIcon.width, 27);
      checkError(104, postItemActionsLoveIcon.pictureProvider.runtimeType,
          ExactAssetPicture);

      final postItemActionsLoveIconPictureProvider =
          postItemActionsLoveIcon.pictureProvider as ExactAssetPicture;
      checkError(
          105,
          postItemActionsLoveIconPictureProvider.assetName,
          posts[0]['isLoved']
              ? 'assets/images/loved_icon.svg'
              : 'assets/images/love_icon.svg');
      final postItemActionsLeftRowSizeBox1Finder = find.byKey(
        const Key('post_item_actions_left_row_sized_box_1'),
      );
      checkError(
        106,
        find.descendant(
            of: postItemActionsLeftRowFinder,
            matching: postItemActionsLeftRowSizeBox1Finder),
        findsOneWidget,
      );

      final postItemActionsLeftRowSizeBox1 =
          postItemActionsLeftRowSizeBox1Finder.evaluate().first.widget
              as SizedBox;
      checkError(107, postItemActionsLeftRowSizeBox1.width, 20);

      final postItemActionsCommentIconFinder = find.byKey(
        const Key('post_item_actions_comment_icon'),
      );

      checkError(
        108,
        find.descendant(
            of: postItemActionsLeftRowFinder,
            matching: postItemActionsCommentIconFinder),
        findsOneWidget,
      );

      final postItemActionsCommentIcon = postItemActionsCommentIconFinder
          .evaluate()
          .first
          .widget as SvgPicture;
      checkError(109, postItemActionsCommentIcon, isA<SvgPicture>());

      checkError(110, postItemActionsCommentIcon.width, 27);
      checkError(111, postItemActionsCommentIcon.pictureProvider.runtimeType,
          ExactAssetPicture);
      final postItemActionsCommentIconPictureProvider =
          postItemActionsCommentIcon.pictureProvider as ExactAssetPicture;
      checkError(112, postItemActionsCommentIconPictureProvider.assetName,
          "assets/images/comment_icon.svg");
      final postItemActionsLeftRowSizeBox2Finder = find.byKey(
        const Key('post_item_actions_left_row_sized_box_2'),
      );
      checkError(
        113,
        find.descendant(
            of: postItemActionsLeftRowFinder,
            matching: postItemActionsLeftRowSizeBox2Finder),
        findsOneWidget,
      );

      final postItemActionsLeftRowSizeBox2 =
          postItemActionsLeftRowSizeBox2Finder.evaluate().first.widget
              as SizedBox;
      checkError(114, postItemActionsLeftRowSizeBox2.width, 20);

      final postItemActionsMessageIconFinder = find.byKey(
        const Key('post_item_actions_message_icon'),
      );
      checkError(
        115,
        find.descendant(
            of: postItemActionsLeftRowFinder,
            matching: postItemActionsMessageIconFinder),
        findsOneWidget,
      );

      final postItemActionsMessageIcon = postItemActionsMessageIconFinder
          .evaluate()
          .first
          .widget as SvgPicture;
      checkError(116, postItemActionsMessageIcon, isA<SvgPicture>());
      checkError(117, postItemActionsMessageIcon.width, 27);
      checkError(118, postItemActionsMessageIcon.pictureProvider.runtimeType,
          ExactAssetPicture);

      final postItemActionsMessageIconPictureProvider =
          postItemActionsMessageIcon.pictureProvider as ExactAssetPicture;
      checkError(119, postItemActionsMessageIconPictureProvider.assetName,
          "assets/images/message_icon.svg");

      final postItemActionsSaveIconFinder = find.byKey(
        const Key('post_item_actions_save_icon'),
      );
      checkError(
        120,
        find.descendant(
            of: postItemActionRowFinder,
            matching: postItemActionsSaveIconFinder),
        findsOneWidget,
      );

      final postItemActionsSaveIcon =
          postItemActionsSaveIconFinder.evaluate().first.widget as SvgPicture;
      checkError(121, postItemActionsSaveIcon, isA<SvgPicture>());
      checkError(122, postItemActionsSaveIcon.width, 27);
      checkError(123, postItemActionsSaveIcon.pictureProvider.runtimeType,
          ExactAssetPicture);

      final postItemActionsSaveIconPictureProvider =
          postItemActionsSaveIcon.pictureProvider as ExactAssetPicture;
      checkError(124, postItemActionsSaveIconPictureProvider.assetName,
          "assets/images/save_icon.svg");

      final postItemCaptionContainerFinder = find.byKey(
        const Key('post_item_caption_container'),
      );
      checkError(
        125,
        find.descendant(
            of: postItemColumnFinder, matching: postItemCaptionContainerFinder),
        findsOneWidget,
      );

      final postItemCaptionContainer =
          postItemCaptionContainerFinder.evaluate().first.widget as Container;
      checkError(126, postItemCaptionContainer, isA<Container>());
      checkError(127, postItemCaptionContainer.padding,
          const EdgeInsets.symmetric(horizontal: 15));
      checkError(128, postItemCaptionContainer.margin,
          const EdgeInsets.only(bottom: 12));

      final postItemCaptionRichTextFinder = find.byKey(
        const Key('post_item_caption_rich_text'),
      );
      checkError(
        129,
        find.descendant(
            of: postItemCaptionContainerFinder,
            matching: postItemCaptionRichTextFinder),
        findsOneWidget,
      );
      final postItemCaptionRichText =
          postItemCaptionRichTextFinder.evaluate().first.widget as RichText;
      checkError(130, postItemCaptionRichText.text, isA<TextSpan>());

      final postItemCaptionRichTextTextSpan =
          postItemCaptionRichText.text as TextSpan;
      checkError(131, postItemCaptionRichTextTextSpan.children, hasLength(2));

      final postItemCaptionRichTextTextSpanTextSpan1 =
          postItemCaptionRichTextTextSpan.children![0] as TextSpan;
      checkError(132, postItemCaptionRichTextTextSpanTextSpan1.text,
          posts[0]['name'] + ' ');
      checkError(133, postItemCaptionRichTextTextSpanTextSpan1.style,
          const TextStyle(fontSize: 15, fontWeight: FontWeight.w700));

      final postItemCaptionRichTextTextSpanTextSpan2 =
          postItemCaptionRichTextTextSpan.children![1] as TextSpan;
      checkError(134, postItemCaptionRichTextTextSpanTextSpan2.text,
          posts[0]['caption']);
      checkError(135, postItemCaptionRichTextTextSpanTextSpan2.style,
          const TextStyle(fontSize: 15, fontWeight: FontWeight.w500));

      final postItemViewCommentsContainerFinder = find.byKey(
        const Key('post_item_view_comments_container'),
      );
      checkError(
        136,
        find.descendant(
            of: postItemColumnFinder,
            matching: postItemViewCommentsContainerFinder),
        findsOneWidget,
      );
      final postItemViewCommentsContainer = postItemViewCommentsContainerFinder
          .evaluate()
          .first
          .widget as Container;
      checkError(137, postItemViewCommentsContainer.padding,
          const EdgeInsets.symmetric(horizontal: 15));
      checkError(138, postItemViewCommentsContainer.margin,
          const EdgeInsets.only(bottom: 12));

      final postItemViewCommentsTextFinder = find.byKey(
        const Key('post_item_view_comments_text'),
      );
      checkError(
        139,
        find.descendant(
            of: postItemViewCommentsContainerFinder,
            matching: postItemViewCommentsTextFinder),
        findsOneWidget,
      );
      final postItemViewCommentsText =
          postItemViewCommentsTextFinder.evaluate().first.widget as Text;
      checkError(140, postItemViewCommentsText.data,
          "View ${posts[0]['commentCount']} comments");
      checkError(141, postItemViewCommentsText.style, isA<TextStyle>());
      checkError(
          142, postItemViewCommentsText.style!.color, white.withOpacity(0.5));
      checkError(143, postItemViewCommentsText.style!.fontSize, 15);
      checkError(
          144, postItemViewCommentsText.style!.fontWeight, FontWeight.w500);

      final postItemAddCommentContainerFinder = find.byKey(
        const Key('post_item_add_comment_container'),
      );
      checkError(
        145,
        find.descendant(
            of: postItemColumnFinder,
            matching: postItemAddCommentContainerFinder),
        findsOneWidget,
      );

      final postItemAddCommentContainer = postItemAddCommentContainerFinder
          .evaluate()
          .first
          .widget as Container;
      checkError(146, postItemAddCommentContainer.padding,
          const EdgeInsets.symmetric(horizontal: 15));
      checkError(147, postItemAddCommentContainer.margin,
          const EdgeInsets.only(bottom: 12));

      final postItemAddCommentRowFinder = find.byKey(
        const Key('post_item_add_comment_row'),
      );
      checkError(
        148,
        find.descendant(
            of: postItemAddCommentContainerFinder,
            matching: postItemAddCommentRowFinder),
        findsOneWidget,
      );

      final postItemAddCommentRow =
          postItemAddCommentRowFinder.evaluate().first.widget as Row;
      checkError(149, postItemAddCommentRow.mainAxisAlignment,
          MainAxisAlignment.spaceBetween);
      checkError(150, postItemAddCommentRow.children, hasLength(2));

      final postItemAddCommentLeftRowFinder = find.byKey(
        const Key('post_item_add_comment_left_row'),
      );
      checkError(
        151,
        find.descendant(
            of: postItemAddCommentRowFinder,
            matching: postItemAddCommentLeftRowFinder),
        findsOneWidget,
      );

      final postItemAddCommentLeftRow =
          postItemAddCommentLeftRowFinder.evaluate().first.widget as Row;
      checkError(152, postItemAddCommentLeftRow.children, hasLength(2));

      final postItemAddCommentAvatarContainerFinder = find.byKey(
        const Key('post_item_add_comment_avatar_container'),
      );
      checkError(
        153,
        find.descendant(
            of: postItemAddCommentLeftRowFinder,
            matching: postItemAddCommentAvatarContainerFinder),
        findsOneWidget,
      );

      final postItemAddCommentAvatarContainer =
          postItemAddCommentAvatarContainerFinder.evaluate().first.widget
              as Container;
      checkError(
          154,
          postItemAddCommentAvatarContainer.constraints!.widthConstraints(),
          const BoxConstraints(minWidth: 30, maxWidth: 30));
      checkError(
          155,
          postItemAddCommentAvatarContainer.constraints!.heightConstraints(),
          const BoxConstraints(minHeight: 30, maxHeight: 30));
      checkError(156, postItemAddCommentAvatarContainer.margin,
          const EdgeInsets.only(right: 15));
      checkError(157, postItemAddCommentAvatarContainer.decoration,
          isA<BoxDecoration>());

      final postItemAddCommentAvatarContainerDecoration =
          postItemAddCommentAvatarContainer.decoration as BoxDecoration;
      checkError(158, postItemAddCommentAvatarContainerDecoration.shape,
          BoxShape.circle);
      checkError(159, postItemAddCommentAvatarContainerDecoration.image,
          isA<DecorationImage>());

      final postItemAddCommentAvatarContainerDecorationImage =
          postItemAddCommentAvatarContainerDecoration.image as DecorationImage;
      checkError(160, postItemAddCommentAvatarContainerDecorationImage.image,
          isA<NetworkImage>());
      checkError(161, postItemAddCommentAvatarContainerDecorationImage.fit,
          BoxFit.cover);

      final postItemAddCommentAvatarContainerDecorationImageNetworkImage =
          postItemAddCommentAvatarContainerDecorationImage.image
              as NetworkImage;
      checkError(
          162,
          postItemAddCommentAvatarContainerDecorationImageNetworkImage.url,
          profile);

      final postItemAddCommentTextFinder = find.byKey(
        const Key('post_item_add_comment_text'),
      );
      checkError(
        163,
        find.descendant(
            of: postItemAddCommentLeftRowFinder,
            matching: postItemAddCommentTextFinder),
        findsOneWidget,
      );

      final postItemAddCommentText =
          postItemAddCommentTextFinder.evaluate().first.widget as Text;
      checkError(164, postItemAddCommentText.data, 'Add a comment...');
      checkError(165, postItemAddCommentText.style, isA<TextStyle>());
      checkError(
          166, postItemAddCommentText.style!.color, white.withOpacity(0.5));
      checkError(167, postItemAddCommentText.style!.fontSize, 15);
      checkError(
          168, postItemAddCommentText.style!.fontWeight, FontWeight.w500);

      final postItemAddCommentRightRowFinder =
          find.byKey(const Key('post_item_add_comment_right_row'));
      checkError(
          169,
          find.descendant(
              of: postItemAddCommentRowFinder,
              matching: postItemAddCommentRightRowFinder),
          findsOneWidget);

      final postItemAddCommentRightRow =
          postItemAddCommentRightRowFinder.evaluate().first.widget as Row;
      checkError(170, postItemAddCommentRightRow.children, hasLength(5));

      final postItemAddLaughEmojiTextFinder = find.byKey(
        const Key('post_item_add_laugh_emoji_text'),
      );
      checkError(
        171,
        find.descendant(
            of: postItemAddCommentRightRowFinder,
            matching: postItemAddLaughEmojiTextFinder),
        findsOneWidget,
      );

      final postItemAddLaughEmojiText =
          postItemAddLaughEmojiTextFinder.evaluate().first.widget as Text;
      checkError(172, postItemAddLaughEmojiText.data, '😂');
      checkError(
          173, postItemAddLaughEmojiText.style, const TextStyle(fontSize: 20));

      final postItemAddLoveEmojiTextFinder = find.byKey(
        const Key('post_item_add_love_emoji_text'),
      );
      checkError(
        174,
        find.descendant(
            of: postItemAddCommentRightRowFinder,
            matching: postItemAddLoveEmojiTextFinder),
        findsOneWidget,
      );

      final postItemAddLoveEmojiText =
          postItemAddLoveEmojiTextFinder.evaluate().first.widget as Text;
      checkError(175, postItemAddLoveEmojiText.data, '😍');
      checkError(
          176, postItemAddLoveEmojiText.style, const TextStyle(fontSize: 20));

      final postItemAddCircleIconFinder = find.byKey(
        const Key('post_item_add_circle_icon'),
      );
      checkError(
        177,
        find.descendant(
            of: postItemAddCommentRightRowFinder,
            matching: postItemAddCircleIconFinder),
        findsOneWidget,
      );

      final postItemAddCircleIcon =
          postItemAddCircleIconFinder.evaluate().first.widget as Icon;
      checkError(178, postItemAddCircleIcon.icon, Icons.add_circle);
      checkError(179, postItemAddCircleIcon.size, 18);
      checkError(180, postItemAddCircleIcon.color, white.withOpacity(0.5));

      final postItemDayAgoPaddingFinder = find.byKey(
        const Key('post_item_day_ago_padding'),
      );
      checkError(
        181,
        find.descendant(
            of: postItemColumnFinder, matching: postItemDayAgoPaddingFinder),
        findsOneWidget,
      );

      final postItemDayAgoPadding =
          postItemDayAgoPaddingFinder.evaluate().first.widget as Padding;
      checkError(182, postItemDayAgoPadding.padding,
          const EdgeInsets.symmetric(horizontal: 15));

      final postItemDayAgoTextFinder = find.byKey(
        const Key('post_item_day_ago_text'),
      );
      checkError(
        183,
        find.descendant(
            of: postItemDayAgoPaddingFinder,
            matching: postItemDayAgoTextFinder),
        findsOneWidget,
      );

      final postItemDayAgoText =
          postItemDayAgoTextFinder.evaluate().first.widget as Text;
      checkError(184, postItemDayAgoText.data, posts[0]['timeAgo']);
      checkError(185, postItemDayAgoText.style!.color, white.withOpacity(0.5));
      checkError(186, postItemDayAgoText.style!.fontSize, 15);
      checkError(187, postItemDayAgoText.style!.fontWeight, FontWeight.w500);
    },
  );

  testWidgets('Check if Bottom Navbar is present', (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        MaterialApp(
          home: HomePage(
              posts: posts, profileData: profileJson, stories: stories),
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
