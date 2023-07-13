import 'package:example_widget_testing/core/theme/colors.dart';
import 'package:example_widget_testing/core/values/constant/story_json.dart';
import 'package:flutter/material.dart';

class UserStory extends StatelessWidget {
  const UserStory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const Key('user_story_padding'),
      padding: const EdgeInsets.only(right: 20, left: 15, bottom: 10),
      child: Column(
        key: const Key('user_story_column'),
        children: <Widget>[
          SizedBox(
            key: const Key('user_story_sized_box'),
            width: 65,
            height: 65,
            child: Stack(
              key: const Key('user_story_stack'),
              children: <Widget>[
                Container(
                  key: const Key('user_story_container'),
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(profile),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  key: const Key('user_story_positioned'),
                  bottom: 0,
                  right: 0,
                  child: Container(
                    key: const Key('user_story_outline_container'),
                    width: 19,
                    height: 19,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Icon(
                      key: Key('user_story_add_circle_icon'),
                      Icons.add_circle,
                      color: buttonFollowColor,
                      size: 19,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            key: Key('user_story_sized_box_spacer'),
            height: 8,
          ),
          SizedBox(
            key: const Key('user_story_sized_box_name'),
            width: 70,
            child: Text(
              key: const Key('user_story_text_name'),
              name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
