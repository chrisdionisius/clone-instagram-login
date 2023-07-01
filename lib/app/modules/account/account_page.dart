import 'package:example_widget_testing/app/modules/account/components/account_name.dart';
import 'package:example_widget_testing/app/modules/account/components/account_tab.dart';
import 'package:example_widget_testing/app/modules/account/components/highlight_list.dart';
import 'package:example_widget_testing/app/modules/account/components/profile_buttons.dart';
import 'package:example_widget_testing/app/modules/account/components/profile_pic.dart';
import 'package:example_widget_testing/app/widgets/bottom_navbar.dart';
import 'package:example_widget_testing/core/values/constant/post_json.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/values/constant/profile_json.dart';
import '../../data/models/profile.dart';
import '../../widgets/post_thumbnail.dart';
import 'components/profile_information.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {
  int pageIndex = 0;
  Profile profile = Profile.fromJson(profileJson);
  void updateIndex(int index) {
    setState(() => pageIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        key: const Key('app_bar_account'),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Row(
          key: const Key('app_bar_row'),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              key: const Key('app_bar_row_name'),
              children: const <Widget>[
                Text(
                  key: Key('app_bar_row_name_text'),
                  "iclop",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Icon(
                  key: Key('app_bar_row_name_arrow_down_icon'),
                  Icons.keyboard_arrow_down,
                ),
              ],
            ),
            Row(
              key: const Key('app_bar_row_menu'),
              children: [
                SvgPicture.asset(
                  key: const Key('app_bar_row_menu_upload_icon'),
                  "assets/images/upload_icon.svg",
                  width: 27,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  key: Key('app_bar_row_menu_hamburger_icon'),
                  Icons.menu,
                  size: 35,
                ),
              ],
            )
          ],
        ),
      ),
      body: ListView(
        key: const Key('account_page_listview'),
        children: <Widget>[
          Row(
            key: const Key('account_page_profile_row'),
            children: <Widget>[
              ProfilePic(pictureUrl: profile.profilePic!),
              Expanded(
                key: const Key('account_page_profile_row_expanded'),
                child: ProfileInformation(profileStats: profile.stats!),
              ),
            ],
          ),
          AccountName(profile: profile),
          const Padding(
            key: Key('account_page_profile_buttons_padding'),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ProfileButtons(),
          ),
          const HighlightList(),
          AccountTab(
            key: const Key("account_tab_row"),
            updateIndex: updateIndex,
            pageIndex: pageIndex,
          ),
          Wrap(
            key: const Key('account_page_post_wrap'),
            spacing: 1.5,
            runSpacing: 1.5,
            children: List.generate(posts.length, (index) {
              return InkWell(
                key: Key("account_post_${posts[index]}_inkwell"),
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
      bottomNavigationBar: const BottomNavbar(pageIndex: 4),
    );
  }
}
