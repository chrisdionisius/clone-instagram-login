import 'package:example_widget_testing/app/data/models/profile.dart';
import 'package:flutter/material.dart';

class ProfileInformation extends StatelessWidget {
  const ProfileInformation({super.key, required this.profileStats});
  final List<Stats> profileStats;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('profile_information_row'),
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        profileStats.length,
        (index) {
          return Column(
            key: Key('profile_information_column_$index'),
            children: <Widget>[
              Text(
                key: Key('profile_information_${index}_amount_text'),
                profileStats[index].count.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                profileStats[index].label!,
                key: Key('profile_information_${index}_label_text'),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
