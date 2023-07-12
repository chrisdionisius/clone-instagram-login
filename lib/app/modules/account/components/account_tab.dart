import 'package:flutter/material.dart';

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
    );
  }
}
