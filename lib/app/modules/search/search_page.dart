import 'package:example_widget_testing/app/widgets/bottom_navbar.dart';
import 'package:example_widget_testing/core/theme/colors.dart';
// import 'package:example_widget_testing/core/values/constant/search_json.dart';
import 'package:flutter/material.dart';

import '../../widgets/post_thumbnail.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.searchPosts});
  final List searchPosts;

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('search_page_scaffold'),
      backgroundColor: Colors.black,
      appBar: const PreferredSize(
        key: Key('search_page_app_bar_preferred_size'),
        preferredSize: Size.fromHeight(0),
        child: SizedBox(
          height: 20,
        ),
      ),
      body: ListView(
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
                debugPrint('clicked');
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
          Wrap(
            key: const Key('search_page_wrap'),
            spacing: 1,
            runSpacing: 1,
            children: widget.searchPosts.map((imageUrl) {
              return PostThumbnail(
                imageUrl: imageUrl,
              );
            }).toList(),
          )
        ],
      ),
      bottomNavigationBar: const BottomNavbar(
        key: Key('search_page_bottom_navbar'),
        pageIndex: 1,
      ),
    );
  }
}
