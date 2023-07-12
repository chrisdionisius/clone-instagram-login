import 'package:flutter/material.dart';
import '../../data/models/profile.dart';

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
    throw UnimplementedError();
  }
}
