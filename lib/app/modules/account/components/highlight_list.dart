import 'package:example_widget_testing/app/modules/account/components/highlight_item.dart';
import 'package:flutter/material.dart';

class HighlightList extends StatelessWidget {
  const HighlightList({super.key, required this.stories});
  final List stories;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const Key('highlight_list_scroll_view'),
      padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
      scrollDirection: Axis.horizontal,
      child: Row(
        key: const Key('highlight_list_parent_row'),
        children: <Widget>[
          Row(
            key: const Key('highlight_list_child_row'),
            children: List.generate(
              stories.length,
              (index) {
                return HighlightItem(
                  key: Key('highlight_item_$index'),
                  img: stories[index]['img'],
                  name: stories[index]['name'],
                );
              },
            ),
          ),
          Padding(
            key: const Key('highlight_list_add_highlight'),
            padding: const EdgeInsets.only(right: 10, bottom: 10),
            child: Column(
              key: const Key('highlight_list_add_highlight_column'),
              children: <Widget>[
                Container(
                  key: const Key('highlight_list_add_highlight_container'),
                  width: 68,
                  height: 68,
                  padding: const EdgeInsets.all(3.0),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  child: Container(
                    key: const Key(
                        'highlight_list_add_highlight_icon_container'),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      key: Key('highlight_list_add_highlight_icon'),
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  key: Key('highlight_list_add_highlight_text_sized_box'),
                  width: 70,
                  child: Text(
                    key: Key('highlight_list_add_highlight_text'),
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
