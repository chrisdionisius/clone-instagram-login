import 'package:example_widget_testing/app/modules/home/components/story_item.dart';
import 'package:example_widget_testing/app/modules/home/home_page.dart';
import 'package:example_widget_testing/app/modules/login/login_page.dart';
import 'package:example_widget_testing/app/widgets/post_item.dart';
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
  testWidgets('Check if Task 2 is finished', (WidgetTester tester) async {
    FlutterError.onError = unfinishedTaskErrorHandler;
    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        const MaterialApp(
          home: LoginPage(),
        ),
      ),
    );
    final loginPageFinder = find.byType(LoginPage);
    checkByTypeFindOneWidget(loginPageFinder);
  });

  testWidgets('Check if Task 3 is finished', (WidgetTester tester) async {
    FlutterError.onError = unfinishedTaskErrorHandler;

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

  testWidgets('Check if Task 4 is finished', (WidgetTester tester) async {
    FlutterError.onError = unfinishedTaskErrorHandler;

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

    final homePageColumnFinder = find.byKey(const Key('home_page_column'));
    final postsColumnFinder = find.byKey(const Key('posts_column'));
    checkWidgetDescendantProperty(homePageColumnFinder, postsColumnFinder);
    checkByKeyFindOneWidget(postsColumnFinder);

    final postsColumn = postsColumnFinder.evaluate().first.widget as Column;
    checkError(53, postsColumn.children.length, posts.length);

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
            onPressed: () {},
          ),
        ),
      ),
    );

    final postItemPaddingFinder = find.byKey(const Key('post_item_padding'));
    checkByKeyFindOneWidget(postItemPaddingFinder);

    final postItemPadding =
        postItemPaddingFinder.evaluate().first.widget as Padding;
    checkWidgetProperty(
      "padding",
      postItemPaddingFinder,
      postItemPadding.padding,
      const EdgeInsets.only(bottom: 10),
    );

    final postItemColumnFinder = find.byKey(const Key('post_item_column'));
    checkWidgetDescendantProperty(postItemPaddingFinder, postItemColumnFinder);

    final postItemColumn =
        postItemColumnFinder.evaluate().first.widget as Column;
    checkWidgetProperty(
      "crossAxisAlignment",
      postItemColumnFinder,
      postItemColumn.crossAxisAlignment,
      CrossAxisAlignment.start,
    );
    // checkError(58, postItemColumn.children.length, 8);

    final postItemUserInfoContainerFinder = find.byKey(
      const Key('post_item_user_info_container'),
    );
    checkWidgetDescendantProperty(
        postItemColumnFinder, postItemUserInfoContainerFinder);

    final postItemUserInfoContainer =
        postItemUserInfoContainerFinder.evaluate().first.widget as Container;
    checkWidgetProperty(
      "padding",
      postItemUserInfoContainerFinder,
      postItemUserInfoContainer.padding,
      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    );

    checkWidgetProperty(
      "margin",
      postItemUserInfoContainerFinder,
      postItemUserInfoContainer.margin,
      const EdgeInsets.only(bottom: 12),
    );

    final postItemUserInfoRowFinder = find.byKey(
      const Key('post_item_user_info_row'),
    );
    checkWidgetDescendantProperty(
        postItemUserInfoContainerFinder, postItemUserInfoRowFinder);

    final postItemUserInfoRow =
        postItemUserInfoRowFinder.evaluate().first.widget as Row;
    checkWidgetProperty(
      "mainAxisAlignment",
      postItemUserInfoRowFinder,
      postItemUserInfoRow.mainAxisAlignment,
      MainAxisAlignment.spaceBetween,
    );
    // checkError(64, postItemUserInfoRow.children.length, 3);

    final postItemUserImgContainerFinder = find.byKey(
      const Key('post_item_user_profile_img_container'),
    );
    checkWidgetDescendantProperty(
        postItemUserInfoRowFinder, postItemUserImgContainerFinder);

    final postItemUserImgContainer =
        postItemUserImgContainerFinder.evaluate().first.widget as Container;
    checkWidgetProperty(
      "width",
      postItemUserImgContainerFinder,
      postItemUserImgContainer.constraints!.maxWidth,
      40,
    );
    checkWidgetProperty(
      "height",
      postItemUserImgContainerFinder,
      postItemUserImgContainer.constraints!.maxHeight,
      40,
    );
    checkWidgetProperty(
      "margin",
      postItemUserImgContainerFinder,
      postItemUserImgContainer.margin,
      const EdgeInsets.only(right: 15),
    );
    checkByKeyIsWidget(
        postItemUserImgContainer.decoration, isA<BoxDecoration>());

    final postItemUserImgContainerDecoration =
        postItemUserImgContainer.decoration as BoxDecoration;
    checkWidgetProperty(
      "shape",
      postItemUserImgContainerFinder,
      postItemUserImgContainerDecoration.shape,
      BoxShape.circle,
    );
    checkByKeyIsWidget(
      postItemUserImgContainerDecoration.image,
      isA<DecorationImage>(),
    );

    final postItemUserImgContainerDecorationImage =
        postItemUserImgContainerDecoration.image as DecorationImage;
    checkByKeyIsWidget(
        postItemUserImgContainerDecorationImage.image, isA<NetworkImage>());
    checkWidgetProperty(
      "fit",
      postItemUserImgContainerFinder,
      postItemUserImgContainerDecorationImage.fit,
      BoxFit.cover,
    );

    final postItemUserImgContainerDecorationImageNetworkImage =
        postItemUserImgContainerDecorationImage.image as NetworkImage;
    checkWidgetProperty(
      "ImageNetworkImage.url",
      postItemUserImgContainerFinder,
      postItemUserImgContainerDecorationImageNetworkImage.url,
      posts[0]['profileImg'],
    );

    final postItemUserNameExpendedFinder = find.byKey(
      const Key('post_item_user_name_expanded'),
    );
    checkWidgetDescendantProperty(
        postItemUserInfoRowFinder, postItemUserNameExpendedFinder);

    final postItemUserNameTextFinder = find.byKey(
      const Key('post_item_user_name_text'),
    );
    checkWidgetDescendantProperty(
        postItemUserNameExpendedFinder, postItemUserNameTextFinder);

    final postItemUserNameText =
        postItemUserNameTextFinder.evaluate().first.widget as Text;
    checkWidgetProperty(
      "data",
      postItemUserNameTextFinder,
      postItemUserNameText.data,
      posts[0]['name'],
    );
    checkByKeyIsWidget(postItemUserNameText.style, isA<TextStyle>());

    final postItemUserNameTextStyle = postItemUserNameText.style as TextStyle;
    checkWidgetProperty(
      "color",
      postItemUserNameTextFinder,
      postItemUserNameTextStyle.color,
      Colors.white,
    );
    checkWidgetProperty(
      "fontWeight",
      postItemUserNameTextFinder,
      postItemUserNameTextStyle.fontWeight,
      FontWeight.w500,
    );
    checkWidgetProperty(
      "fontSize",
      postItemUserNameTextFinder,
      postItemUserNameTextStyle.fontSize,
      15,
    );

    final postItemUserMoreIconFinder = find.byKey(
      const Key('post_item_user_more_icon'),
    );
    checkWidgetDescendantProperty(
        postItemUserInfoRowFinder, postItemUserMoreIconFinder);

    final postItemUserMoreIcon =
        postItemUserMoreIconFinder.evaluate().first.widget as Icon;
    checkWidgetProperty(
      "icon",
      postItemUserMoreIconFinder,
      postItemUserMoreIcon.icon,
      Icons.more_horiz,
    );
    checkWidgetProperty(
      "color",
      postItemUserMoreIconFinder,
      postItemUserMoreIcon.color,
      Colors.white,
    );

    final postItemImageContainerFinder = find.byKey(
      const Key('post_item_image_container'),
    );
    checkWidgetDescendantProperty(
        postItemColumnFinder, postItemImageContainerFinder);

    final postItemImageContainer =
        postItemImageContainerFinder.evaluate().first.widget as Container;
    checkWidgetProperty(
      "height",
      postItemImageContainerFinder,
      postItemImageContainer.constraints!.maxHeight,
      400,
    );
    checkWidgetProperty(
      "margin",
      postItemImageContainerFinder,
      postItemImageContainer.margin,
      const EdgeInsets.only(bottom: 10),
    );
    checkByKeyIsWidget(postItemImageContainer.decoration, isA<BoxDecoration>());

    final postItemImageContainerDecoration =
        postItemImageContainer.decoration as BoxDecoration;
    checkByKeyIsWidget(
        postItemImageContainerDecoration.image, isA<DecorationImage>());

    final postItemImageContainerDecorationImage =
        postItemImageContainerDecoration.image as DecorationImage;
    checkByKeyIsWidget(
        postItemImageContainerDecorationImage.image, isA<NetworkImage>());
    checkWidgetProperty(
      "fit",
      postItemImageContainerFinder,
      postItemImageContainerDecorationImage.fit,
      BoxFit.cover,
    );

    final postItemImageContainerDecorationImageNetworkImage =
        postItemImageContainerDecorationImage.image as NetworkImage;
    checkWidgetProperty(
      "ImageNetworkImage.url",
      postItemImageContainerFinder,
      postItemImageContainerDecorationImageNetworkImage.url,
      posts[0]['postImg'],
    );

    final postItemActionContainerFinder =
        find.byKey(const Key('post_item_actions_container'));
    checkWidgetDescendantProperty(
        postItemColumnFinder, postItemActionContainerFinder);

    final postItemActionContainer =
        postItemActionContainerFinder.evaluate().first.widget as Container;
    checkWidgetProperty(
      "padding",
      postItemActionContainerFinder,
      postItemActionContainer.padding,
      const EdgeInsets.fromLTRB(15, 3, 15, 0),
    );
    checkWidgetProperty(
      "margin",
      postItemActionContainerFinder,
      postItemActionContainer.margin,
      const EdgeInsets.only(bottom: 12),
    );

    final postItemActionRowFinder = find.byKey(
      const Key('post_item_actions_row'),
    );
    checkWidgetDescendantProperty(
      postItemActionContainerFinder,
      postItemActionRowFinder,
    );

    final postItemActionRow =
        postItemActionRowFinder.evaluate().first.widget as Row;
    checkWidgetProperty(
      "mainAxisAlignment",
      postItemActionRowFinder,
      postItemActionRow.mainAxisAlignment,
      MainAxisAlignment.spaceBetween,
    );
    // checkError(98, postItemActionRow.children.length, 2);

    final postItemActionsLeftRowFinder = find.byKey(
      const Key('post_item_actions_left_row'),
    );
    checkWidgetDescendantProperty(
        postItemActionRowFinder, postItemActionsLeftRowFinder);

    // final postItemActionsLeftRow =
    //     postItemActionsLeftRowFinder.evaluate().first.widget as Row;
    // checkError(100, postItemActionsLeftRow.children.length, 5);

    final postItemActionsLoveIconFinder = find.byKey(
      const Key('post_item_actions_love_icon'),
    );
    checkWidgetDescendantProperty(
        postItemActionsLeftRowFinder, postItemActionsLoveIconFinder);

    final postItemActionsLoveIcon =
        postItemActionsLoveIconFinder.evaluate().first.widget as SvgPicture;
    checkByKeyIsWidget(postItemActionsLoveIcon, isA<SvgPicture>());
    checkWidgetProperty(
      "width",
      postItemActionsLoveIconFinder,
      postItemActionsLoveIcon.width,
      27,
    );
    checkWidgetProperty(
      "pictureProvider.runtimeType",
      postItemActionsLoveIconFinder,
      postItemActionsLoveIcon.pictureProvider.runtimeType,
      ExactAssetPicture,
    );

    final postItemActionsLoveIconPictureProvider =
        postItemActionsLoveIcon.pictureProvider as ExactAssetPicture;
    checkWidgetProperty(
      "assetName",
      postItemActionsLoveIconFinder,
      postItemActionsLoveIconPictureProvider.assetName,
      posts[0]['isLoved']
          ? 'assets/images/loved_icon.svg'
          : 'assets/images/love_icon.svg',
    );
    final postItemActionsLeftRowSizeBox1Finder = find.byKey(
      const Key('post_item_actions_left_row_sized_box_1'),
    );
    checkWidgetDescendantProperty(
        postItemActionsLeftRowFinder, postItemActionsLeftRowSizeBox1Finder);

    final postItemActionsLeftRowSizeBox1 = postItemActionsLeftRowSizeBox1Finder
        .evaluate()
        .first
        .widget as SizedBox;
    checkWidgetProperty(
      "width",
      postItemActionsLeftRowSizeBox1Finder,
      postItemActionsLeftRowSizeBox1.width,
      20,
    );

    final postItemActionsCommentIconFinder = find.byKey(
      const Key('post_item_actions_comment_icon'),
    );
    checkWidgetDescendantProperty(
        postItemActionsLeftRowFinder, postItemActionsCommentIconFinder);

    final postItemActionsCommentIcon =
        postItemActionsCommentIconFinder.evaluate().first.widget as SvgPicture;
    checkByKeyIsWidget(postItemActionsCommentIcon, isA<SvgPicture>());
    checkWidgetProperty(
      "width",
      postItemActionsCommentIconFinder,
      postItemActionsCommentIcon.width,
      27,
    );
    checkWidgetProperty(
      "pictureProvider.runtimeType",
      postItemActionsCommentIconFinder,
      postItemActionsCommentIcon.pictureProvider.runtimeType,
      ExactAssetPicture,
    );

    final postItemActionsCommentIconPictureProvider =
        postItemActionsCommentIcon.pictureProvider as ExactAssetPicture;
    checkWidgetProperty(
      "assetName",
      postItemActionsCommentIconFinder,
      postItemActionsCommentIconPictureProvider.assetName,
      "assets/images/comment_icon.svg",
    );

    final postItemActionsLeftRowSizeBox2Finder = find.byKey(
      const Key('post_item_actions_left_row_sized_box_2'),
    );
    checkWidgetDescendantProperty(
        postItemActionsLeftRowFinder, postItemActionsLeftRowSizeBox2Finder);

    final postItemActionsLeftRowSizeBox2 = postItemActionsLeftRowSizeBox2Finder
        .evaluate()
        .first
        .widget as SizedBox;
    checkWidgetProperty(
      "width",
      postItemActionsLeftRowSizeBox2Finder,
      postItemActionsLeftRowSizeBox2.width,
      20,
    );

    final postItemActionsMessageIconFinder = find.byKey(
      const Key('post_item_actions_message_icon'),
    );
    checkWidgetDescendantProperty(
        postItemActionsLeftRowFinder, postItemActionsMessageIconFinder);

    final postItemActionsMessageIcon =
        postItemActionsMessageIconFinder.evaluate().first.widget as SvgPicture;
    checkByKeyIsWidget(postItemActionsMessageIcon, isA<SvgPicture>());
    checkWidgetProperty(
      "width",
      postItemActionsMessageIconFinder,
      postItemActionsMessageIcon.width,
      27,
    );
    checkWidgetProperty(
      "pictureProvider.runtimeType",
      postItemActionsMessageIconFinder,
      postItemActionsMessageIcon.pictureProvider.runtimeType,
      ExactAssetPicture,
    );

    final postItemActionsMessageIconPictureProvider =
        postItemActionsMessageIcon.pictureProvider as ExactAssetPicture;
    checkWidgetProperty(
      "assetName",
      postItemActionsMessageIconFinder,
      postItemActionsMessageIconPictureProvider.assetName,
      "assets/images/message_icon.svg",
    );

    final postItemActionsSaveIconFinder = find.byKey(
      const Key('post_item_actions_save_icon'),
    );
    checkWidgetDescendantProperty(
        postItemActionRowFinder, postItemActionsSaveIconFinder);

    final postItemActionsSaveIcon =
        postItemActionsSaveIconFinder.evaluate().first.widget as SvgPicture;
    checkByKeyIsWidget(postItemActionsSaveIcon, isA<SvgPicture>());
    checkWidgetProperty(
      "width",
      postItemActionsSaveIconFinder,
      postItemActionsSaveIcon.width,
      27,
    );
    checkWidgetProperty(
        "pictureProvider.runtimeType",
        postItemActionsSaveIconFinder,
        postItemActionsSaveIcon.pictureProvider.runtimeType,
        ExactAssetPicture);

    final postItemActionsSaveIconPictureProvider =
        postItemActionsSaveIcon.pictureProvider as ExactAssetPicture;
    checkWidgetProperty(
      "assetName",
      postItemActionsSaveIconFinder,
      postItemActionsSaveIconPictureProvider.assetName,
      "assets/images/save_icon.svg",
    );

    final postItemCaptionContainerFinder = find.byKey(
      const Key('post_item_caption_container'),
    );
    checkWidgetDescendantProperty(
      postItemColumnFinder,
      postItemCaptionContainerFinder,
    );

    final postItemCaptionContainer =
        postItemCaptionContainerFinder.evaluate().first.widget as Container;
    checkByKeyIsWidget(postItemCaptionContainer, isA<Container>());
    checkWidgetProperty(
      "padding",
      postItemCaptionContainerFinder,
      postItemCaptionContainer.padding,
      const EdgeInsets.symmetric(horizontal: 15),
    );
    checkWidgetProperty(
      "margin",
      postItemCaptionContainerFinder,
      postItemCaptionContainer.margin,
      const EdgeInsets.only(bottom: 12),
    );

    final postItemCaptionRichTextFinder = find.byKey(
      const Key('post_item_caption_rich_text'),
    );
    checkWidgetDescendantProperty(
        postItemCaptionContainerFinder, postItemCaptionRichTextFinder);

    final postItemCaptionRichText =
        postItemCaptionRichTextFinder.evaluate().first.widget as RichText;
    checkByKeyIsWidget(postItemCaptionRichText.text, isA<TextSpan>());

    final postItemCaptionRichTextTextSpan =
        postItemCaptionRichText.text as TextSpan;
    // checkError(131, postItemCaptionRichTextTextSpan.children, hasLength(2));

    final postItemCaptionRichTextTextSpanTextSpan1 =
        postItemCaptionRichTextTextSpan.children![0] as TextSpan;
    checkWidgetProperty("text", postItemCaptionRichTextTextSpanTextSpan1,
        postItemCaptionRichTextTextSpanTextSpan1.text, posts[0]['name'] + ' ');
    checkWidgetProperty(
      "text",
      postItemCaptionRichTextTextSpanTextSpan1,
      postItemCaptionRichTextTextSpanTextSpan1.style,
      const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
    );

    final postItemCaptionRichTextTextSpanTextSpan2 =
        postItemCaptionRichTextTextSpan.children![1] as TextSpan;
    checkWidgetProperty("text", postItemCaptionRichTextTextSpanTextSpan2,
        postItemCaptionRichTextTextSpanTextSpan2.text, posts[0]['caption']);
    checkWidgetProperty(
      "text",
      postItemCaptionRichTextTextSpanTextSpan2,
      postItemCaptionRichTextTextSpanTextSpan2.style,
      const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
    );

    final postItemViewCommentsContainerFinder = find.byKey(
      const Key('post_item_view_comments_container'),
    );
    checkWidgetDescendantProperty(
        postItemColumnFinder, postItemViewCommentsContainerFinder);

    final postItemViewCommentsContainer = postItemViewCommentsContainerFinder
        .evaluate()
        .first
        .widget as Container;
    checkWidgetProperty(
      "padding",
      postItemViewCommentsContainerFinder,
      postItemViewCommentsContainer.padding,
      const EdgeInsets.symmetric(horizontal: 15),
    );
    checkWidgetProperty(
      "margin",
      postItemViewCommentsContainerFinder,
      postItemViewCommentsContainer.margin,
      const EdgeInsets.only(bottom: 12),
    );

    final postItemViewCommentsTextFinder = find.byKey(
      const Key('post_item_view_comments_text'),
    );
    checkWidgetDescendantProperty(
        postItemViewCommentsContainerFinder, postItemViewCommentsTextFinder);

    final postItemViewCommentsText =
        postItemViewCommentsTextFinder.evaluate().first.widget as Text;
    checkWidgetProperty(
      "data",
      postItemViewCommentsTextFinder,
      postItemViewCommentsText.data,
      "View ${posts[0]['commentCount']} comments",
    );
    checkByKeyIsWidget(postItemViewCommentsText.style, isA<TextStyle>());
    checkWidgetProperty(
      "color",
      postItemViewCommentsTextFinder,
      postItemViewCommentsText.style!.color,
      white.withOpacity(0.5),
    );
    checkWidgetProperty(
      "fontSize",
      postItemViewCommentsTextFinder,
      postItemViewCommentsText.style!.fontSize,
      15,
    );
    checkWidgetProperty(
      "fontWeight",
      postItemViewCommentsTextFinder,
      postItemViewCommentsText.style!.fontWeight,
      FontWeight.w500,
    );

    final postItemAddCommentContainerFinder = find.byKey(
      const Key('post_item_add_comment_container'),
    );
    checkWidgetDescendantProperty(
        postItemColumnFinder, postItemAddCommentContainerFinder);

    final postItemAddCommentContainer =
        postItemAddCommentContainerFinder.evaluate().first.widget as Container;
    checkWidgetProperty(
      "padding",
      postItemAddCommentContainerFinder,
      postItemAddCommentContainer.padding,
      const EdgeInsets.symmetric(horizontal: 15),
    );
    checkWidgetProperty(
      "margin",
      postItemAddCommentContainerFinder,
      postItemAddCommentContainer.margin,
      const EdgeInsets.only(bottom: 12),
    );

    final postItemAddCommentRowFinder = find.byKey(
      const Key('post_item_add_comment_row'),
    );
    checkWidgetDescendantProperty(
        postItemAddCommentContainerFinder, postItemAddCommentRowFinder);

    final postItemAddCommentRow =
        postItemAddCommentRowFinder.evaluate().first.widget as Row;
    checkWidgetProperty(
      "mainAxisAlignment",
      postItemAddCommentRowFinder,
      postItemAddCommentRow.mainAxisAlignment,
      MainAxisAlignment.spaceBetween,
    );
    // checkError(150, postItemAddCommentRow.children, hasLength(2));

    final postItemAddCommentLeftRowFinder = find.byKey(
      const Key('post_item_add_comment_left_row'),
    );
    checkWidgetDescendantProperty(
        postItemAddCommentRowFinder, postItemAddCommentLeftRowFinder);

    // final postItemAddCommentLeftRow =
    //     postItemAddCommentLeftRowFinder.evaluate().first.widget as Row;
    // checkError(152, postItemAddCommentLeftRow.children, hasLength(2));

    final postItemAddCommentAvatarContainerFinder = find.byKey(
      const Key('post_item_add_comment_avatar_container'),
    );
    checkWidgetDescendantProperty(postItemAddCommentLeftRowFinder,
        postItemAddCommentAvatarContainerFinder);

    final postItemAddCommentAvatarContainer =
        postItemAddCommentAvatarContainerFinder.evaluate().first.widget
            as Container;
    checkWidgetProperty(
      "width",
      postItemAddCommentAvatarContainerFinder,
      postItemAddCommentAvatarContainer.constraints!.widthConstraints(),
      const BoxConstraints(minWidth: 30, maxWidth: 30),
    );
    checkWidgetProperty(
      "height",
      postItemAddCommentAvatarContainerFinder,
      postItemAddCommentAvatarContainer.constraints!.heightConstraints(),
      const BoxConstraints(minHeight: 30, maxHeight: 30),
    );
    checkWidgetProperty(
      "margin",
      postItemAddCommentAvatarContainerFinder,
      postItemAddCommentAvatarContainer.margin,
      const EdgeInsets.only(right: 15),
    );
    checkByKeyIsWidget(
        postItemAddCommentAvatarContainer.decoration, isA<BoxDecoration>());

    final postItemAddCommentAvatarContainerDecoration =
        postItemAddCommentAvatarContainer.decoration as BoxDecoration;
    checkWidgetProperty(
      "shape",
      postItemAddCommentAvatarContainerFinder,
      postItemAddCommentAvatarContainerDecoration.shape,
      BoxShape.circle,
    );
    checkByKeyIsWidget(postItemAddCommentAvatarContainerDecoration.image,
        isA<DecorationImage>());

    final postItemAddCommentAvatarContainerDecorationImage =
        postItemAddCommentAvatarContainerDecoration.image as DecorationImage;
    checkByKeyIsWidget(postItemAddCommentAvatarContainerDecorationImage.image,
        isA<NetworkImage>());
    checkWidgetProperty(
      "DecorationImage.fit",
      postItemAddCommentAvatarContainerFinder,
      postItemAddCommentAvatarContainerDecorationImage.fit,
      BoxFit.cover,
    );

    final postItemAddCommentAvatarContainerDecorationImageNetworkImage =
        postItemAddCommentAvatarContainerDecorationImage.image as NetworkImage;
    checkWidgetProperty(
      "DecorationImageNetworkImage.url",
      postItemAddCommentAvatarContainerFinder,
      postItemAddCommentAvatarContainerDecorationImageNetworkImage.url,
      profile,
    );

    final postItemAddCommentTextFinder = find.byKey(
      const Key('post_item_add_comment_text'),
    );
    checkWidgetDescendantProperty(
        postItemAddCommentLeftRowFinder, postItemAddCommentTextFinder);

    final postItemAddCommentText =
        postItemAddCommentTextFinder.evaluate().first.widget as Text;
    checkWidgetProperty(
      "data",
      postItemAddCommentTextFinder,
      postItemAddCommentText.data,
      'Add a comment...',
    );
    checkByKeyIsWidget(postItemAddCommentText.style, isA<TextStyle>());
    checkWidgetProperty(
      "color",
      postItemAddCommentTextFinder,
      postItemAddCommentText.style!.color,
      white.withOpacity(0.5),
    );
    checkWidgetProperty(
      "fontSize",
      postItemAddCommentTextFinder,
      postItemAddCommentText.style!.fontSize,
      15,
    );
    checkWidgetProperty(
      "fontWeight",
      postItemAddCommentTextFinder,
      postItemAddCommentText.style!.fontWeight,
      FontWeight.w500,
    );

    final postItemAddCommentRightRowFinder =
        find.byKey(const Key('post_item_add_comment_right_row'));
    checkWidgetDescendantProperty(
        postItemAddCommentRowFinder, postItemAddCommentRightRowFinder);

    // final postItemAddCommentRightRow =
    //     postItemAddCommentRightRowFinder.evaluate().first.widget as Row;
    // checkError(170, postItemAddCommentRightRow.children, hasLength(5));

    final postItemAddLaughEmojiTextFinder = find.byKey(
      const Key('post_item_add_laugh_emoji_text'),
    );
    checkWidgetDescendantProperty(
        postItemAddCommentRightRowFinder, postItemAddLaughEmojiTextFinder);

    final postItemAddLaughEmojiText =
        postItemAddLaughEmojiTextFinder.evaluate().first.widget as Text;
    checkWidgetProperty(
      "data",
      postItemAddLaughEmojiTextFinder,
      postItemAddLaughEmojiText.data,
      '😂',
    );
    checkWidgetProperty(
      "style",
      postItemAddLaughEmojiTextFinder,
      postItemAddLaughEmojiText.style,
      const TextStyle(fontSize: 20),
    );

    final postItemAddLoveEmojiTextFinder = find.byKey(
      const Key('post_item_add_love_emoji_text'),
    );
    checkWidgetDescendantProperty(
        postItemAddCommentRightRowFinder, postItemAddLoveEmojiTextFinder);

    final postItemAddLoveEmojiText =
        postItemAddLoveEmojiTextFinder.evaluate().first.widget as Text;
    checkWidgetProperty(
      "data",
      postItemAddLoveEmojiTextFinder,
      postItemAddLoveEmojiText.data,
      '😍',
    );
    checkWidgetProperty(
      "style",
      postItemAddLoveEmojiTextFinder,
      postItemAddLoveEmojiText.style,
      const TextStyle(fontSize: 20),
    );

    final postItemAddCircleIconFinder = find.byKey(
      const Key('post_item_add_circle_icon'),
    );
    checkWidgetDescendantProperty(
        postItemAddCommentRightRowFinder, postItemAddCircleIconFinder);

    final postItemAddCircleIcon =
        postItemAddCircleIconFinder.evaluate().first.widget as Icon;
    checkWidgetProperty(
      "icon",
      postItemAddCircleIconFinder,
      postItemAddCircleIcon.icon,
      Icons.add_circle,
    );
    checkWidgetProperty(
      "size",
      postItemAddCircleIconFinder,
      postItemAddCircleIcon.size,
      18,
    );
    checkWidgetProperty(
      "color",
      postItemAddCircleIconFinder,
      postItemAddCircleIcon.color,
      white.withOpacity(0.5),
    );

    final postItemDayAgoPaddingFinder = find.byKey(
      const Key('post_item_day_ago_padding'),
    );
    checkWidgetDescendantProperty(
        postItemColumnFinder, postItemDayAgoPaddingFinder);

    final postItemDayAgoPadding =
        postItemDayAgoPaddingFinder.evaluate().first.widget as Padding;
    checkWidgetProperty(
      "padding",
      postItemDayAgoPaddingFinder,
      postItemDayAgoPadding.padding,
      const EdgeInsets.symmetric(horizontal: 15),
    );

    final postItemDayAgoTextFinder = find.byKey(
      const Key('post_item_day_ago_text'),
    );
    checkWidgetDescendantProperty(
        postItemDayAgoPaddingFinder, postItemDayAgoTextFinder);

    final postItemDayAgoText =
        postItemDayAgoTextFinder.evaluate().first.widget as Text;
    checkWidgetProperty(
      "data",
      postItemDayAgoTextFinder,
      postItemDayAgoText.data,
      posts[0]['timeAgo'],
    );
    checkWidgetProperty(
      "color",
      postItemDayAgoTextFinder,
      postItemDayAgoText.style!.color,
      white.withOpacity(0.5),
    );
    checkWidgetProperty(
      "fontSize",
      postItemDayAgoTextFinder,
      postItemDayAgoText.style!.fontSize,
      15,
    );
    checkWidgetProperty(
      "fontWeight",
      postItemDayAgoTextFinder,
      postItemDayAgoText.style!.fontWeight,
      FontWeight.w500,
    );
  });
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
