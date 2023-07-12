import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({super.key, required this.pictureUrl});
  final String pictureUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('profile_pic_container'),
    );
  }
}
