import 'package:flutter/material.dart';

import '../../../../core/values/constant/profile_tabs_json.dart';

class AccountTab extends StatelessWidget {
  final Function(int index) updateIndex;
  final int pageIndex;

  const AccountTab(
      {super.key, required this.updateIndex, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      key: const Key("account_tab_row"),
      children: List.generate(
        tabs.length,
        (index) {
          return DecoratedBox(
            key: Key('account_tab_decorated_box_$index'),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: pageIndex == index ? Colors.white : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            child: ElevatedButton(
              key: Key('account_tab_elevated_button_$index'),
              onPressed: () => updateIndex(index),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.transparent,
                minimumSize: Size(size.width / tabs.length, 40),
              ),
              child: Icon(
                tabs[index]['icon'],
                key: Key('account_tab_icon_$index'),
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
