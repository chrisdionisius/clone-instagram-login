import 'package:example_widget_testing/app/widgets/bottom_navbar.dart';
import 'package:example_widget_testing/app/widgets/post_item.dart';
import 'package:example_widget_testing/core/values/constant/post_json.dart';
import 'package:example_widget_testing/core/values/constant/story_json.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  PostPageState createState() => PostPageState();
}

class PostPageState extends State<PostPage> {
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
      ),
      bottomNavigationBar: const BottomNavbar(pageIndex: 4),
    );
  }
}
