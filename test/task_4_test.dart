import 'package:example_widget_testing/app/modules/home/home_page.dart';
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
  testWidgets('Check if Posts Column is present', (WidgetTester tester) async {
    FlutterError.onError = customFlutterErrorHandler;

    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        MaterialApp(
          home: HomePage(
              posts: posts, profileData: profileJson, stories: stories),
        ),
      ),
    );

    final homePageColumnFinder = find.byKey(const Key('home_page_column'));
    final postsColumnFinder = find.byKey(const Key('posts_column'));
    checkWidgetDescendantProperty(homePageColumnFinder, postsColumnFinder);
    checkByKeyFindOneWidget(postsColumnFinder);

    final postsColumn = postsColumnFinder.evaluate().first.widget as Column;
    checkError(53, postsColumn.children.length, posts.length);
  });

  testWidgets(
    'Check if PostItem rendered correctly',
    (WidgetTester tester) async {
      FlutterError.onError = customFlutterErrorHandler;
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
      checkWidgetDescendantProperty(
          postItemPaddingFinder, postItemColumnFinder);

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
      checkByKeyIsWidget(
          postItemImageContainer.decoration, isA<BoxDecoration>());

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

      final postItemActionsLeftRowSizeBox1 =
          postItemActionsLeftRowSizeBox1Finder.evaluate().first.widget
              as SizedBox;
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

      final postItemActionsCommentIcon = postItemActionsCommentIconFinder
          .evaluate()
          .first
          .widget as SvgPicture;
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

      final postItemActionsLeftRowSizeBox2 =
          postItemActionsLeftRowSizeBox2Finder.evaluate().first.widget
              as SizedBox;
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

      final postItemActionsMessageIcon = postItemActionsMessageIconFinder
          .evaluate()
          .first
          .widget as SvgPicture;
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
      checkWidgetProperty(
          "text",
          postItemCaptionRichTextTextSpanTextSpan1,
          postItemCaptionRichTextTextSpanTextSpan1.text,
          posts[0]['name'] + ' ');
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

      final postItemAddCommentContainer = postItemAddCommentContainerFinder
          .evaluate()
          .first
          .widget as Container;
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
          postItemAddCommentAvatarContainerDecorationImage.image
              as NetworkImage;
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
    },
  );
}
