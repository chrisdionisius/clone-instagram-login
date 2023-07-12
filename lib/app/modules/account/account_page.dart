import 'package:flutter/material.dart';
import '../../data/models/profile.dart';

class AccountPage extends StatefulWidget {
  const AccountPage(
      {super.key,
      required this.profileData,
      required this.posts,
      required this.stories});
  final Map<String, dynamic> profileData;
  final List posts;
  final List stories;

  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {
  int pageIndex = 0;

  void updateIndex(int index) {
    setState(() => pageIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final Profile profile = Profile.fromJson(widget.profileData);
    throw UnimplementedError();
  }
}
