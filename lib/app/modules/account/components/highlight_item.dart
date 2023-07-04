import 'package:example_widget_testing/core/theme/colors.dart';
import 'package:flutter/material.dart';

class HighlightItem extends StatelessWidget {
  final String img;
  final String name;

  const HighlightItem({super.key, required this.img, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const Key('highlight_item_padding'),
      padding: const EdgeInsets.only(right: 10, bottom: 10),
      child: Column(
        key: const Key('highlight_item_column'),
        children: <Widget>[
          Container(
            key: const Key('highlight_item_container'),
            width: 68,
            height: 68,
            padding: const EdgeInsets.all(3.0),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: (Colors.grey[800])!,
                width: 1,
              ),
            ),
            child: Container(
              key: const Key('highlight_item_image_container'),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(img),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            key: const Key('highlight_item_text_sized_box'),
            width: 70,
            child: Text(
              key: const Key('highlight_item_text'),
              name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: white),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
