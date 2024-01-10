import 'package:example_widget_testing/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:line_icons/line_icons.dart';

class PostItem extends StatelessWidget {
  final String profileImg;
  final String name;
  final String postImg;
  final String caption;
  final bool isLoved;
  final String likedBy;
  final String viewCount;
  final String dayAgo;
  final String userPhoto;
  final VoidCallback onPressed;

  const PostItem({
    super.key,
    required this.profileImg,
    required this.name,
    required this.postImg,
    required this.caption,
    required this.isLoved,
    required this.likedBy,
    required this.viewCount,
    required this.dayAgo,
    required this.userPhoto,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const Key('post_item_padding'),
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        key: const Key('post_item_column'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            key: const Key('post_item_user_info_container'),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            margin: const EdgeInsets.only(bottom: 12),
            child: Row(
              key: const Key('post_item_user_info_row'),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  key: const Key('post_item_user_profile_img_container'),
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(profileImg),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  key: const Key('post_item_user_name_expanded'),
                  child: Text(
                    key: const Key('post_item_user_name_text'),
                    name,
                    style: const TextStyle(
                      color: white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(
                  key: Key('post_item_user_more_icon'),
                  Icons.more_horiz,
                  color: white,
                )
              ],
            ),
          ),
          Stack(
            children: [
              Material(
                child: InkWell(
                  onDoubleTap: () => onPressed(),
                  child: Container(
                    key: const Key('post_item_image_container'),
                    height: 400,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(postImg),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              // put love icon here
              Positioned(
                key: const Key('post_item_love_icon_positioned'),
                bottom: 20,
                right: 20,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onPressed,
                    child: SvgPicture.asset(
                      key: const Key('post_item_love_icon'),
                      isLoved
                          ? "assets/images/loved_icon.svg"
                          : "assets/images/love_icon.svg",
                      width: 27,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            key: const Key('post_item_actions_container'),
            padding: const EdgeInsets.fromLTRB(15, 3, 15, 0),
            margin: const EdgeInsets.only(bottom: 12),
            child: Row(
              key: const Key('post_item_actions_row'),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  key: const Key('post_item_actions_left_row'),
                  children: <Widget>[
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onPressed,
                        child: SvgPicture.asset(
                          key: const Key('post_item_actions_love_icon'),
                          isLoved
                              ? "assets/images/loved_icon.svg"
                              : "assets/images/love_icon.svg",
                          width: 27,
                        ),
                      ),
                    ),
                    const SizedBox(
                        key: Key('post_item_actions_left_row_sized_box_1'),
                        width: 20),
                    SvgPicture.asset(
                      "assets/images/comment_icon.svg",
                      key: const Key('post_item_actions_comment_icon'),
                      width: 27,
                    ),
                    const SizedBox(
                        key: Key('post_item_actions_left_row_sized_box_2'),
                        width: 20),
                    SvgPicture.asset(
                      "assets/images/message_icon.svg",
                      key: const Key('post_item_actions_message_icon'),
                      width: 27,
                    ),
                  ],
                ),
                SvgPicture.asset(
                  "assets/images/save_icon.svg",
                  key: const Key('post_item_actions_save_icon'),
                  width: 27,
                ),
              ],
            ),
          ),
          Container(
            key: const Key('post_item_likes_container'),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            margin: const EdgeInsets.only(bottom: 12),
            child: RichText(
              key: const Key('post_item_likes_rich_text'),
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Liked by $likedBy and Other",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            key: const Key('post_item_caption_container'),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            margin: const EdgeInsets.only(bottom: 12),
            child: RichText(
              key: const Key('post_item_caption_rich_text'),
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "$name ",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text: caption,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          Container(
            key: const Key('post_item_view_comments_container'),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            margin: const EdgeInsets.only(bottom: 12),
            child: Text(
              key: const Key('post_item_view_comments_text'),
              "View $viewCount comments",
              style: TextStyle(
                  color: white.withOpacity(0.5),
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            key: const Key('post_item_add_comment_container'),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            margin: const EdgeInsets.only(bottom: 12),
            child: Row(
              key: const Key('post_item_add_comment_row'),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  key: const Key('post_item_add_comment_left_row'),
                  children: <Widget>[
                    Container(
                      key: const Key('post_item_add_comment_avatar_container'),
                      width: 30,
                      height: 30,
                      margin: const EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(userPhoto),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      key: const Key('post_item_add_comment_text'),
                      "Add a comment...",
                      style: TextStyle(
                        color: white.withOpacity(0.5),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  key: const Key('post_item_add_comment_right_row'),
                  children: <Widget>[
                    const Text(
                      key: Key('post_item_add_laugh_emoji_text'),
                      "😂",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      key: Key('post_item_add_love_emoji_text'),
                      "😍",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      key: const Key('post_item_add_circle_icon'),
                      Icons.add_circle,
                      color: white.withOpacity(0.5),
                      size: 18,
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            key: const Key('post_item_day_ago_padding'),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              key: const Key('post_item_day_ago_text'),
              dayAgo,
              style: TextStyle(
                color: white.withOpacity(0.5),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
