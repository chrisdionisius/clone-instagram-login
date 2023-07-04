import 'package:example_widget_testing/app/modules/account/components/grey_button.dart';
import 'package:flutter/material.dart';

class ProfileButtons extends StatelessWidget {
  const ProfileButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const Key('profile_buttons_padding'),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        key: const Key('profile_buttons_row'),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            key: const Key('profile_buttons_edit_profile_button_expanded'),
            child: GreyButton(
              key: const Key('profile_buttons_edit_profile_button'),
              onPressed: () {},
              child: const Text(
                key: Key('profile_buttons_edit_profile_button_text'),
                "Edit Profile",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            key: const Key('profile_buttons_share_profile_button_expanded'),
            child: GreyButton(
              key: const Key('profile_buttons_share_profile_button'),
              onPressed: () {},
              child: const Text(
                key: Key('profile_buttons_share_profile_button_text'),
                "Share profile",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          GreyButton(
            key: const Key('profile_buttons_discover_people_button'),
            onPressed: () {},
            child: const Icon(
              key: Key("profile_buttons_discover_people_icon"),
              Icons.person_add_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
