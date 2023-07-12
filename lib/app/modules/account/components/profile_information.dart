import 'package:example_widget_testing/app/data/models/profile.dart';
import 'package:flutter/material.dart';

class ProfileInformation extends StatelessWidget {
  const ProfileInformation({super.key, required this.profileStats});
  final List<Stats> profileStats;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('profile_information_row'),
    );
  }
}
