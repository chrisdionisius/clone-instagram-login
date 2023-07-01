import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({super.key, required this.pictureUrl});
  final String pictureUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('profile_pic_container'),
      width: 80,
      height: 80,
      margin: const EdgeInsets.only(left: 15, right: 30),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(pictureUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
