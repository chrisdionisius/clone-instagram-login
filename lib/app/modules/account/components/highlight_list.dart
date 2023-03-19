import 'package:example_widget_testing/app/modules/account/components/highlight_item.dart';
import 'package:example_widget_testing/core/values/constant/story_json.dart';
import 'package:flutter/material.dart';

class HighlightList extends StatelessWidget {
  const HighlightList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 15),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          Row(
            children: List.generate(
              stories.length,
              (index) {
                return HighlightItem(
                  img: stories[index]['img'],
                  name: stories[index]['name'],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 10),
            child: Column(
              children: <Widget>[
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const SizedBox(
                  width: 70,
                  child: Text(
                    'New',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
