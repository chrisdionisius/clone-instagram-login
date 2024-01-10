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
  void updatePostLike(id) {
    setState(() {
      for (var element in listPost) {
        if (element.id == id) {
          element.isLoved = !element.isLoved!;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    posts = widget.posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('post_page_scaffold'),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Post"),
      ),
      body: SingleChildScrollView(
        key: const Key('post_page_single_child_scroll_view'),
        child: Column(
          key: const Key('post_page_column'),
          children: <Widget>[
            Column(
              key: const Key('post_page_column'),
              children: listPost.map((post) {
                return PostItem(
                  key: Key('post_item_${post.id}'), // add key for testing
                  postImg: post.postImg!,
                  profileImg: post.profileImg!,
                  name: post.name!,
                  caption: post.caption!,
                  isLoved: post.isLoved!,
                  viewCount: post.commentCount!,
                  likedBy: post.likedBy!,
                  dayAgo: post.timeAgo!,
                  userPhoto: profile,
                  onPressed: () => updatePostLike(post.id!),
                );
              }).toList(),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavbar(
        key: Key('post_page_bottom_navbar'),
        pageIndex: 4,
      ),
    );
  }
}
