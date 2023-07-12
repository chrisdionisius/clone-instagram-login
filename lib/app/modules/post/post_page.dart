import 'package:example_widget_testing/core/values/constant/post_json.dart';
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
    throw UnimplementedError();
  }
}
