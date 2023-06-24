import 'package:example_widget_testing/core/theme/colors.dart';
import 'package:example_widget_testing/core/values/constant/search_json.dart';
import 'package:flutter/material.dart';

import '../../widgets/post_thumbnail.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  int pageIndex = 0;

  Widget getBody() {
    return ListView(
      key: const Key('search_page_listview'),
      children: <Widget>[
        Container(
          key: const Key('search_page_textfield_container'),
          margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
          height: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: textFieldBackground),
          child: TextField(
            key: const Key('search_page_textfield'),
            onTap: () {
              setState(() {
                pageIndex = 1;
              });
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                color: white.withOpacity(0.3),
              ),
            ),
            style: TextStyle(color: white.withOpacity(0.3)),
            cursorColor: white.withOpacity(0.3),
          ),
        ),
        // Container(
        //   margin: const EdgeInsets.only(bottom: 15),
        //   height: 40,
        //   child: ListView(
        //     scrollDirection: Axis.horizontal,
        //     padding: const EdgeInsets.symmetric(horizontal: 15),
        //     children: searchCategories.map((category) {
        //       return CategoryStoryItem(
        //         name: category,
        //       );
        //     }).toList(),
        //   ),
        // ),
        Wrap(
          key: const Key('search_page_wrap'),
          spacing: 1,
          runSpacing: 1,
          children: searchImages.map((imageUrl) {
            return PostThumbnail(
              imageUrl: imageUrl,
            );
          }).toList(),
        )
      ],
    );
  }
}
