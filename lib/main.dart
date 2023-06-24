import 'package:example_widget_testing/app/modules/account/account_page.dart';
import 'package:example_widget_testing/app/modules/home/home_page.dart';
import 'package:example_widget_testing/app/modules/login/login_page.dart';
import 'package:example_widget_testing/app/modules/post/post_page.dart';
import 'package:example_widget_testing/app/modules/search/search_page.dart';
import 'package:flutter/material.dart';

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
        '/home': (context) => const HomePage(),
        '/search': (context) => const SearchPage(),
        '/upload': (context) => const LoginPage(),
        '/love': (context) => const LoginPage(),
        '/account': (context) => const AccountPage(),
        '/post': (context) => const PostPage(),
      },
    );
  }
}
