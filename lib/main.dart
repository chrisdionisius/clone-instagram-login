import 'package:example_widget_testing/app/modules/account/account_page.dart';
import 'package:example_widget_testing/app/modules/activity/activity_page.dart';
import 'package:example_widget_testing/app/modules/home/home_page.dart';
import 'package:example_widget_testing/app/modules/login/login_page.dart';
import 'package:example_widget_testing/app/modules/post/post_page.dart';
import 'package:example_widget_testing/app/modules/search/search_page.dart';
import 'package:example_widget_testing/core/values/constant/post_json.dart';
import 'package:example_widget_testing/core/values/constant/profile_json.dart';
import 'package:example_widget_testing/core/values/constant/search_json.dart';
import 'package:flutter/material.dart';

import 'app/modules/upload/upload_page.dart';
import 'core/values/constant/story_json.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) =>
            HomePage(posts: posts, stories: stories, profileData: profileJson),
        '/search': (context) => SearchPage(searchPosts: searchImages),
        '/upload': (context) => const UploadPage(),
        '/activity': (context) => const ActivityPage(),
        '/account': (context) => AccountPage(
            profileData: profileJson, posts: posts, stories: stories),
        '/post': (context) => PostPage(posts: posts),
      },
    );
  }
}
