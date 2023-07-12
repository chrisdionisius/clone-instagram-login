import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  final String profileImg;
  final String name;
  final String postImg;
  final String caption;
  final bool isLoved;
  final String likedBy;
  final String viewCount;
  final String dayAgo;
  final String userPhoto;

  const PostItem({
    super.key,
    required this.profileImg,
    required this.name,
    required this.postImg,
    required this.caption,
    required this.isLoved,
    required this.likedBy,
    required this.viewCount,
    required this.dayAgo,
    required this.userPhoto,
  });

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
