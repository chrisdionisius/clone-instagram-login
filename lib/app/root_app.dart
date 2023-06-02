import 'package:example_widget_testing/app/modules/home/home_page.dart';
import 'package:example_widget_testing/app/modules/account/account_page.dart';
import 'package:example_widget_testing/app/modules/post/post_page.dart';
import 'package:example_widget_testing/app/modules/search/search_page.dart';
import 'package:example_widget_testing/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  RootAppState createState() => RootAppState();
}

class RootAppState extends State<RootApp> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: getAppBar(),
      ),
      backgroundColor: black,
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      const HomePage(),
      const SearchPage(),
      const Center(
        child: Text(
          "Upload Page",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: white,
          ),
        ),
      ),
      const Center(
        child: Text(
          "Activity Page",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: white,
          ),
        ),
      ),
      const AccountPage(),
      const PostPage(),
    ];
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getAppBar() {
    if (pageIndex == 0) {
      return AppBar(
        key: const Key("app_bar_home"),
        backgroundColor: Colors.black,
        leading: const Icon(Icons.camera_alt),
        title: const Center(
          child: Text(
            "Instagram",
            style: TextStyle(fontFamily: 'Billabong', fontSize: 35),
          ),
        ),
        actions: const <Widget>[
          Icon(Icons.send),
        ],
      );
    } else if (pageIndex == 1) {
      return const PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: SizedBox(
          height: 20,
        ),
      );
    } else if (pageIndex == 2) {
      return AppBar(
        backgroundColor: appBarColor,
        title: const Text("Upload"),
      );
    } else if (pageIndex == 3) {
      return AppBar(
        backgroundColor: appBarColor,
        title: const Text("Activity"),
      );
    } else {
      return AppBar(
        backgroundColor: Colors.black,
        // remove back button
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: const <Widget>[
                Text(
                  "yonoplamir",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/images/upload_icon.svg",
                  width: 27,
                ),
                const SizedBox(
                  width: 10,
                ),
                // hamburger menu icon
                const Icon(Icons.menu, size: 35),
              ],
            )
          ],
        ),
      );
    }
  }

  Widget getFooter() {
    List bottomItems = [
      pageIndex == 0
          ? "assets/images/home_active_icon.svg"
          : "assets/images/home_icon.svg",
      pageIndex == 1
          ? "assets/images/search_active_icon.svg"
          : "assets/images/search_icon.svg",
      pageIndex == 2
          ? "assets/images/upload_active_icon.svg"
          : "assets/images/upload_icon.svg",
      pageIndex == 3
          ? "assets/images/love_active_icon.svg"
          : "assets/images/love_icon.svg",
      pageIndex == 4
          ? "assets/images/account_active_icon.svg"
          : "assets/images/account_icon.svg",
    ];
    return Container(
      key: const Key("bottom_navigation_bar_container"),
      width: double.infinity,
      height: 55,
      color: Colors.black,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 15),
      child: Row(
        key: const Key("bottom_navigation_bar_row"),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(bottomItems.length, (index) {
          return InkWell(
            key: Key("bottom_item_$index"),
            onTap: () {
              selectedTab(index);
            },
            child: SvgPicture.asset(
              bottomItems[index],
              width: 27,
            ),
          );
        }),
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
