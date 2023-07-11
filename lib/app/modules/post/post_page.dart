import 'package:example_widget_testing/app/widgets/bottom_navbar.dart';
import 'package:example_widget_testing/app/widgets/post_item.dart';
import 'package:example_widget_testing/core/values/constant/post_json.dart';
import 'package:example_widget_testing/core/values/constant/story_json.dart';
import 'package:flutter/material.dart';

import '../../data/models/post.dart';

class PostPage extends StatefulWidget {
  final List posts;
  const PostPage({super.key, required this.posts});

  @override
  PostPageState createState() => PostPageState();
}

class PostPageState extends State<PostPage> {
  final List<Post> listPost = posts.map((e) => Post.fromJson(e)).toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Post"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(
              children: listPost.map((post) {
                return PostItem(
                  postImg: post.postImg!,
                  profileImg: post.profileImg!,
                  name: post.name!,
                  caption: post.caption!,
                  isLoved: post.isLoved!,
                  viewCount: post.commentCount!,
                  likedBy: post.likedBy!,
                  dayAgo: post.timeAgo!,
                  userPhoto: profile,
                );
              }).toList(),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavbar(pageIndex: 4),
    );
  }
}
