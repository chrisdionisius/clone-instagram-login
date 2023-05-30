import 'package:example_widget_testing/app/modules/home/components/user_story.dart';
import 'package:example_widget_testing/app/widgets/post_item.dart';
import 'package:example_widget_testing/app/modules/home/components/story_item.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';
import '../../../core/values/constant/post_json.dart';
import '../../../core/values/constant/story_json.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Widget getBody() {
    return SingleChildScrollView(
      key: const Key('home_page_single_child_scroll_view'),
      child: Column(
        key: const Key('home_page_column'),
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                const UserStory(),
                Row(
                  key: const Key('stories'),
                  children: List.generate(
                    stories.length,
                    (index) {
                      return StoryItem(
                        img: stories[index]['img'],
                        name: stories[index]['name'],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Divider(
            key: const Key('divider'),
            color: white.withOpacity(0.3),
          ),
          Column(
            key: const Key('posts_column'),
            children: List.generate(
              posts.length,
              (index) {
                return PostItem(
                  postImg: posts[index]['postImg'],
                  profileImg: posts[index]['profileImg'],
                  name: posts[index]['name'],
                  caption: posts[index]['caption'],
                  isLoved: posts[index]['isLoved'],
                  viewCount: posts[index]['commentCount'],
                  likedBy: posts[index]['likedBy'],
                  dayAgo: posts[index]['timeAgo'],
                  userPhoto: profile,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
