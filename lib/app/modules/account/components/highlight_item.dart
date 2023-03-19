import 'package:example_widget_testing/core/theme/colors.dart';
import 'package:flutter/material.dart';

class HighlightItem extends StatelessWidget {
  final String img;
  final String name;

  const HighlightItem({super.key, required this.img, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, bottom: 10),
      child: Column(
        children: <Widget>[
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: (Colors.grey[800])!,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  border: Border.all(color: black, width: 2),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                        img,
                      ),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: 70,
            child: Text(
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
