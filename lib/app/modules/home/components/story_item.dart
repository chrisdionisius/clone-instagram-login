import 'package:example_widget_testing/core/theme/colors.dart';
import 'package:flutter/material.dart';

class StoryItem extends StatelessWidget {
  final String img;
  final String name;

  const StoryItem({
    super.key,
    required this.img,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const Key('story_item_padding'),
      padding: const EdgeInsets.only(right: 20, bottom: 10),
      child: Column(
        key: const Key('story_item_column'),
        children: <Widget>[
          Container(
            key: const Key('story_item_container'),
            width: 68,
            height: 68,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: storyBorderColor),
            ),
            child: Container(
              key: const Key('story_item_image_container'),
              margin: const EdgeInsets.all(3),
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                border: Border.all(color: black, width: 2),
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(img),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            key: const Key('story_item_username_sizedbox'),
            width: 70,
            child: Text(
              name,
              key: const Key('story_item_username_text'),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: white),
            ),
          )
        ],
      ),
    );
  }
}
