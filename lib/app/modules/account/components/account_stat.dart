import 'package:flutter/widgets.dart';

import '../../../data/models/profile.dart';

class AccountStat extends StatelessWidget {
  final Profile profile;

  const AccountStat({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('account_page_profile_row'),
    );
  }
}
