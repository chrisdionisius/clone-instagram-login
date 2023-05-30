import 'package:example_widget_testing/app/widgets/post_item.dart';
import 'package:example_widget_testing/core/values/constant/post_json.dart';
import 'package:example_widget_testing/core/values/constant/story_json.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  PostPageState createState() => PostPageState();
}

class PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  int pageIndex = 4;

  Widget getBody() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Posts",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
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
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getFooter() {
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
    return Container(
      width: double.infinity,
      height: 55,
      decoration: const BoxDecoration(color: Colors.black),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(bottomItems.length, (index) {
            return SvgPicture.asset(
              bottomItems[index],
              width: 27,
            );
          }),
        ),
      ),
    );
  }
}
