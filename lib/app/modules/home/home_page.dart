import 'package:example_widget_testing/app/modules/home/components/user_story.dart';
import 'package:example_widget_testing/app/widgets/post_item.dart';
import 'package:example_widget_testing/app/modules/home/components/story_item.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';
import '../../data/models/profile.dart';
import '../../widgets/bottom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key,
      required this.posts,
      required this.stories,
      required this.profileData});
  final List posts;
  final List stories;
  final Map<String, dynamic> profileData;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Profile profile = Profile.fromJson(widget.profileData);
    return Scaffold(
      key: const Key('home_page_scaffold'),
      backgroundColor: Colors.black,
      appBar: AppBar(
        key: const Key("home_page_appbar"),
        backgroundColor: Colors.black,
        leading: const Icon(
          key: Key('home_page_camera_icon'),
          Icons.camera_alt,
        ),
        title: const Center(
          key: Key('home_page_title_center'),
          child: Text(
            key: Key('home_page_title_text'),
            "Instagram",
            style: TextStyle(fontFamily: 'Billabong', fontSize: 35),
          ),
        ),
        actions: const <Widget>[
          Icon(key: Key('home_page_send_icon'), Icons.send),
        ],
      ),
      body: SingleChildScrollView(
        key: const Key('home_page_single_child_scroll_view'),
        child: Column(
          key: const Key('home_page_column'),
          children: <Widget>[
            SingleChildScrollView(
              key: const Key('stories_scroll_view'),
              scrollDirection: Axis.horizontal,
              child: Row(
                key: const Key('stories_row'),
                children: <Widget>[
                  const UserStory(key: Key('user_story')),
                  Row(
                    key: const Key('following_stories_row'),
                    children: List.generate(
                      widget.stories.length,
                      (index) {
                        return StoryItem(
                          key: Key('story_item_$index'),
                          img: widget.stories[index]['img'],
                          name: widget.stories[index]['name'],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              key: const Key('home_page_divider'),
              color: white.withOpacity(0.3),
            ),
            Column(
              key: const Key('posts_column'),
              children: List.generate(
                widget.posts.length,
                (index) {
                  return PostItem(
                    key: Key('post_item_$index'),
                    postImg: widget.posts[index]['postImg'],
                    profileImg: widget.posts[index]['profileImg'],
                    name: widget.posts[index]['name'],
                    caption: widget.posts[index]['caption'],
                    isLoved: widget.posts[index]['isLoved'],
                    viewCount: widget.posts[index]['commentCount'],
                    likedBy: widget.posts[index]['likedBy'],
                    dayAgo: widget.posts[index]['timeAgo'],
                    userPhoto: profile.profilePic!,
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavbar(
        key: Key('home_page_bottom_navbar'),
        pageIndex: 0,
      ),
    );
  }
}
