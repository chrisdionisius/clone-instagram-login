import 'package:flutter/widgets.dart';

class PostThumbnail extends StatelessWidget {
  final String imageUrl;

  const PostThumbnail({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      key: Key(imageUrl),
      width: (size.width - 3) / 3,
      height: (size.width - 3) / 3,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
