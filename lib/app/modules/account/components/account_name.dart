import 'package:flutter/material.dart';

import '../../../data/models/profile.dart';

class AccountName extends StatelessWidget {
  const AccountName({super.key, required this.profile});
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('account_name_container'),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        key: const Key('account_name_column'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            key: const Key('account_name_text'),
            profile.name!,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          Text(
            key: const Key('account_bio_text'),
            profile.bio!,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
