import 'package:example_widget_testing/app/modules/account/components/account_name.dart';
import 'package:example_widget_testing/app/modules/account/components/highlight_list.dart';
import 'package:example_widget_testing/app/modules/account/components/information.dart';
import 'package:example_widget_testing/app/modules/account/components/profile_buttons.dart';
import 'package:example_widget_testing/app/modules/account/components/profile_pic.dart';
import 'package:example_widget_testing/app/widgets/bottom_navbar.dart';
import 'package:example_widget_testing/core/theme/colors.dart';
import 'package:example_widget_testing/core/values/constant/post_json.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/post_thumbnail.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: const <Widget>[
                ProfilePic(),
                SizedBox(width: 30),
                Expanded(child: ProfileInformation()),
              ],
            ),
            const SizedBox(height: 10),
            const AccountName(),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ProfileButtons(),
            ),
            const SizedBox(height: 10),
            const HighlightList(),
            const SizedBox(height: 10),
            // add instagram account tab
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      pageIndex = 0;
                    });
                  },
                  child: Container(
                    width: size.width / 2,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white,
                          width: (pageIndex == 0) ? 2 : 0,
                        ),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.grid_on_outlined,
                        color: white,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      pageIndex = 1;
                    });
                  },
                  child: Container(
                    width: size.width / 2,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white,
                          width: (pageIndex == 1) ? 2 : 0,
                        ),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        // tagged account
                        Icons.person_pin_outlined,
                        color: white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Wrap(
              spacing: 1.5,
              runSpacing: 1.5,
              children: List.generate(posts.length, (index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/post');
                  },
                  child: PostThumbnail(
                    key: Key(posts[index]['postImg']),
                    imageUrl: posts[index]['postImg'],
                  ),
                );
              }),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavbar(pageIndex: 4),
    );
  }
}
