import 'package:flutter/material.dart';

import '../../../data/models/profile.dart';

class AccountName extends StatelessWidget {
  const AccountName({super.key, required this.profile});
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('account_name_container'),
    );
  }
}
