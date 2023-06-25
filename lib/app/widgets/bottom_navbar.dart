import 'package:example_widget_testing/core/values/constant/navbarmenu_json.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavbar extends StatelessWidget {
  final int pageIndex;
  const BottomNavbar({super.key, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    void navigateToPage(int index) {
      Navigator.pushNamed(context, navbarMenuList[index].path!);
    }

    return Container(
      key: const Key("bottom_navigation_bar_container"),
      width: double.infinity,
      height: 55,
      color: Colors.black,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 15),
      child: Row(
        key: const Key("bottom_navigation_bar_row"),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(navbarMenuList.length, (index) {
          return InkWell(
            key: Key("bottom_item_$index"),
            onTap: () {
              navigateToPage(index);
            },
            child: SvgPicture.asset(
              pageIndex == index
                  ? navbarMenuList[index].activeIcon!
                  : navbarMenuList[index].inactiveIcon!,
              width: 27,
            ),
          );
        }),
      ),
    );
  }
}
