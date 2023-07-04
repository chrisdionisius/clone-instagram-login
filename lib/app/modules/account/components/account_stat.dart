import 'package:example_widget_testing/app/modules/account/components/profile_information.dart';
import 'package:example_widget_testing/app/modules/account/components/profile_pic.dart';
import 'package:flutter/widgets.dart';

import '../../../data/models/profile.dart';

class AccountStat extends StatelessWidget {
  final Profile profile;

  const AccountStat({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('account_page_profile_row'),
      children: <Widget>[
        ProfilePic(
          key: const Key("profile_pic"),
          pictureUrl: profile.profilePic!,
        ),
        Expanded(
          key: const Key('account_page_profile_information_expanded'),
          child: ProfileInformation(
            key: const Key("profile_information"),
            profileStats: profile.stats!,
          ),
        ),
      ],
    );
  }
}
