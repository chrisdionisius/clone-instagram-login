import 'package:example_widget_testing/app/data/models/profile.dart';
import 'package:example_widget_testing/app/modules/account/account_page.dart';
import 'package:example_widget_testing/app/modules/account/components/account_name.dart';
import 'package:example_widget_testing/app/modules/account/components/account_stat.dart';
import 'package:example_widget_testing/app/modules/account/components/account_tab.dart';
import 'package:example_widget_testing/app/modules/account/components/grey_button.dart';
import 'package:example_widget_testing/app/modules/account/components/highlight_item.dart';
import 'package:example_widget_testing/app/modules/account/components/highlight_list.dart';
import 'package:example_widget_testing/app/modules/account/components/profile_buttons.dart';
import 'package:example_widget_testing/app/modules/account/components/profile_information.dart';
import 'package:example_widget_testing/app/modules/account/components/profile_pic.dart';
import 'package:example_widget_testing/app/widgets/post_thumbnail.dart';
import 'package:example_widget_testing/core/values/constant/post_json.dart';
import 'package:example_widget_testing/core/values/constant/profile_json.dart';
import 'package:example_widget_testing/core/values/constant/profile_tabs_json.dart';
import 'package:example_widget_testing/core/values/constant/story_json.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'helper.dart';

bool checkError(int index, dynamic expected, dynamic matcher) {
  if (expected == null) {
    debugPrint('Account Page Test-$index failed: expected is null');
    return false;
  }
  try {
    expect(expected, matcher);
  } catch (e) {
    debugPrint('Account Page Test-$index failed:');
    debugPrint(e.toString());
    return false;
  }
  return true;
}

final Profile profile = Profile.fromJson(profileJson);

void main() {
  final states = <MaterialState>{};
  testWidgets('Check if Account page Appbar is present',
      (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        MaterialApp(
          home: AccountPage(
            posts: posts,
            stories: stories,
            profileData: profileJson,
          ),
        ),
      ),
    );

    final appBarFinder = find.byKey(const Key('app_bar_account'));
    checkError(2, appBarFinder, findsOneWidget);

    final appBar = appBarFinder.evaluate().first.widget as AppBar;
    checkError(3, appBar.backgroundColor, Colors.black);
    checkError(4, appBar.automaticallyImplyLeading, false);
    final appBarRowFinder = find.byKey(const Key('app_bar_row'));
    if (checkError(5, appBarRowFinder, findsOneWidget)) {
      final appBarRow = appBarRowFinder.evaluate().first.widget as Row;
      checkError(
          6, appBarRow.mainAxisAlignment, MainAxisAlignment.spaceBetween);
      checkError(7, appBarRow.children.length, 2);

      final appBarRowNameFinder = find.byKey(const Key('app_bar_row_name'));
      if (checkError(
        8,
        find.descendant(of: appBarRowFinder, matching: appBarRowNameFinder),
        findsOneWidget,
      )) {
        final appBarRowName =
            appBarRowNameFinder.evaluate().first.widget as Row;
        checkError(9, appBarRowName.children.length, 2);

        final appBarRowNameTextFinder =
            find.byKey(const Key('app_bar_row_name_text'));
        if (checkError(
            10,
            find.descendant(
                of: appBarRowNameFinder, matching: appBarRowNameTextFinder),
            findsOneWidget)) {
          final appBarRowNameText =
              appBarRowNameTextFinder.evaluate().first.widget as Text;
          checkError(11, appBarRowNameText.data, 'iclop');
          checkError(12, appBarRowNameText.style!.fontWeight, FontWeight.bold);

          final appBarRowNameArrowDownIconFinder =
              find.byKey(const Key('app_bar_row_name_arrow_down_icon'));
          if (checkError(
              13,
              find.descendant(
                  of: appBarRowNameFinder,
                  matching: appBarRowNameArrowDownIconFinder),
              findsOneWidget)) {
            final appBarRowNameArrowDownIcon = appBarRowNameArrowDownIconFinder
                .evaluate()
                .first
                .widget as Icon;
            checkError(
                14, appBarRowNameArrowDownIcon.icon, Icons.keyboard_arrow_down);
          }
        }
      }

      final appBarRowMenuFinder = find.byKey(const Key('app_bar_row_menu'));
      bool appBarRowMenuIsAvailable = checkError(
          15,
          find.descendant(of: appBarRowFinder, matching: appBarRowMenuFinder),
          findsOneWidget);
      if (appBarRowMenuIsAvailable) {
        final appBarRowMenu =
            appBarRowMenuFinder.evaluate().first.widget as Row;
        checkError(16, appBarRowMenu.children.length, 3);

        final appBarRowMenuUploadIconFinder =
            find.byKey(const Key('app_bar_row_menu_upload_icon'));
        bool appBarRowMenuUploadIconIsAvailable = checkError(
            17,
            find.descendant(
                of: appBarRowMenuFinder,
                matching: appBarRowMenuUploadIconFinder),
            findsOneWidget);
        bool appBarRowMenuUploadIconIsSvgPicture = checkError(
            18,
            appBarRowMenuUploadIconFinder.evaluate().first.widget,
            isA<SvgPicture>());
        if (appBarRowMenuUploadIconIsAvailable &&
            appBarRowMenuUploadIconIsSvgPicture) {
          final appBarRowMenuUploadIcon = appBarRowMenuUploadIconFinder
              .evaluate()
              .first
              .widget as SvgPicture;
          checkError(19, appBarRowMenuUploadIcon.width, 27);
          bool appBarRowMenuUploadIconIsAssetPicture = checkError(
              20,
              appBarRowMenuUploadIcon.pictureProvider.runtimeType,
              ExactAssetPicture);
          if (appBarRowMenuUploadIconIsAssetPicture) {
            final appBarRowMenuUploadIconAssetPicture =
                appBarRowMenuUploadIcon.pictureProvider as ExactAssetPicture;
            checkError(21, appBarRowMenuUploadIconAssetPicture.assetName,
                "assets/images/upload_icon.svg");
          }
        }

        final appBarRowMenuHamburgerIconFinder =
            find.byKey(const Key('app_bar_row_menu_hamburger_icon'));
        bool appBarRowMenuHamburgerIconIsAvailable = checkError(
            22,
            find.descendant(
                of: appBarRowMenuFinder,
                matching: appBarRowMenuHamburgerIconFinder),
            findsOneWidget);
        bool appBarRowMenuHamburgerIconIsIcon = checkError(
            23,
            appBarRowMenuHamburgerIconFinder.evaluate().first.widget,
            isA<Icon>());
        if (appBarRowMenuHamburgerIconIsAvailable &&
            appBarRowMenuHamburgerIconIsIcon) {
          final appBarRowMenuHamburgerIcon =
              appBarRowMenuHamburgerIconFinder.evaluate().first.widget as Icon;
          checkError(24, appBarRowMenuHamburgerIcon.size, 35);
          checkError(25, appBarRowMenuHamburgerIcon.icon, Icons.menu);
        }
      }
    }
  });
  testWidgets("Check if Account page body is present", (widgetTester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await mockNetworkImagesFor(
      () => widgetTester.pumpWidget(
        MaterialApp(
          home: AccountPage(
            posts: posts,
            stories: stories,
            profileData: profileJson,
          ),
        ),
      ),
    );

    final accountPageListViewFinder = find.byKey(
      const Key('account_page_listview'),
    );
    checkError(26, accountPageListViewFinder, findsOneWidget);

    final accountStatFinder = find.byKey(const Key('account_stat'));
    checkError(27, accountStatFinder, findsOneWidget);

    final accountNameFinder = find.byKey(const Key('account_name'));
    checkError(28, accountNameFinder, findsOneWidget);

    final profileButtons = find.byKey(const Key('profile_buttons'));
    checkError(29, profileButtons, findsOneWidget);

    final highlightList = find.byKey(const Key('highlight_list'));
    checkError(30, highlightList, findsOneWidget);

    final accountTab = find.byKey(const Key('account_tab'));
    checkError(31, accountTab, findsOneWidget);

    final accountPagePostWrapFinder =
        find.byKey(const Key('account_page_post_wrap'));
    bool isAccountPagePostWrapAvailable = checkError(
      32,
      accountPagePostWrapFinder,
      findsOneWidget,
    );
    if (isAccountPagePostWrapAvailable) {
      final accountPagePostWrap =
          accountPagePostWrapFinder.evaluate().first.widget as Wrap;
      checkError(33, accountPagePostWrap.spacing, 1.5);
      checkError(34, accountPagePostWrap.runSpacing, 1.5);
      checkError(35, accountPagePostWrap.children.length, posts.length);
      posts.asMap().forEach((key, value) {
        final accountPostInkWellFinder = find.byKey(
          Key('account_post_inkwell_$key'),
        );
        bool isAccountPostInkWellAvailable = checkError(
          351,
          accountPostInkWellFinder,
          findsOneWidget,
        );
        if (isAccountPostInkWellAvailable) {
          checkError(
            352,
            accountPostInkWellFinder.evaluate().first.widget,
            isA<InkWell>(),
          );
          final accountPostThumbnailFinder = find.byKey(
            Key('account_post_thumbnail_$key'),
          );
          bool isAccountPostThumbnailAvailable = checkError(
            353,
            accountPostThumbnailFinder,
            findsOneWidget,
          );
          if (isAccountPostThumbnailAvailable) {
            bool accountPostThumbnailIsPostThumbnail = checkError(
              354,
              accountPostThumbnailFinder.evaluate().first.widget,
              isA<PostThumbnail>(),
            );
            if (accountPostThumbnailIsPostThumbnail) {
              final accountPostThumbnail = accountPostThumbnailFinder
                  .evaluate()
                  .first
                  .widget as PostThumbnail;
              checkError(
                355,
                accountPostThumbnail.imageUrl,
                posts[key]['postImg'],
              );
            }
          }
        }
      });
    }
  });
  testWidgets("Check if account stats is present", (widgetTester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await mockNetworkImagesFor(
      () => widgetTester.pumpWidget(
        MaterialApp(
          home: AccountStat(profile: profile),
        ),
      ),
    );

    final accountPageProfileRowFinder =
        find.byKey(const Key('account_page_profile_row'));
    bool accounntPageListViewIsAvailable = checkError(
      26,
      accountPageProfileRowFinder,
      findsOneWidget,
    );
    bool accounntPageListViewIsRow = checkError(
      27,
      accountPageProfileRowFinder.evaluate().first.widget,
      isA<Row>(),
    );
    if (accounntPageListViewIsAvailable && accounntPageListViewIsRow) {
      final accountPageProfileRow =
          accountPageProfileRowFinder.evaluate().first.widget as Row;
      checkError(28, accountPageProfileRow.children.length, 2);

      final profilePicFinder = find.byKey(const Key('profile_pic'));
      checkError(29, profilePicFinder, findsOneWidget);

      final accountPageProfileInformationExpandedFinder = find.byKey(
        const Key('account_page_profile_information_expanded'),
      );
      bool accountPageProfileInformationExpandedIsAvailable = checkError(
        30,
        accountPageProfileInformationExpandedFinder,
        findsOneWidget,
      );

      checkError(
        31,
        accountPageProfileInformationExpandedFinder.evaluate().first.widget,
        isA<Expanded>(),
      );

      if (accountPageProfileInformationExpandedIsAvailable) {
        final profileInformationFinder = find.byKey(
          const Key('profile_information'),
        );
        checkError(
          32,
          find.descendant(
            of: accountPageProfileInformationExpandedFinder,
            matching: profileInformationFinder,
          ),
          findsOneWidget,
        );
      }
    }
  });
  testWidgets("Check if profile picture is rendered correctly",
      (widgetTester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await mockNetworkImagesFor(
      () => widgetTester.pumpWidget(
        MaterialApp(
          home: ProfilePic(pictureUrl: profile.profilePic!),
        ),
      ),
    );

    final profilePicContainerFinder = find.byKey(
      const Key('profile_pic_container'),
    );
    bool profilePicContainerIsAvailable = checkError(
      33,
      profilePicContainerFinder,
      findsOneWidget,
    );
    if (profilePicContainerIsAvailable) {
      bool profilePicContainerIsContainer = checkError(
        34,
        profilePicContainerFinder.evaluate().first.widget,
        isA<Container>(),
      );
      if (profilePicContainerIsContainer) {
        final profilePicContainer =
            profilePicContainerFinder.evaluate().first.widget as Container;
        checkError(
          35,
          profilePicContainer.constraints!.widthConstraints(),
          const BoxConstraints(minWidth: 80, maxWidth: 80),
        );
        checkError(
          36,
          profilePicContainer.constraints!.heightConstraints(),
          const BoxConstraints(minHeight: 80, maxHeight: 80),
        );
        checkError(
          37,
          profilePicContainer.margin,
          const EdgeInsets.only(left: 15, right: 30),
        );
        final profilePicDecoration =
            profilePicContainer.decoration as BoxDecoration;
        bool profilePicDecorationIsBoxDecoration = checkError(
          38,
          profilePicDecoration,
          isA<BoxDecoration>(),
        );

        if (profilePicDecorationIsBoxDecoration) {
          final profilePicDecoration =
              profilePicContainer.decoration as BoxDecoration;
          checkError(
            39,
            profilePicDecoration.shape,
            BoxShape.circle,
          );

          bool profilePicDecorationImageIsDecorationImage = checkError(
            40,
            profilePicDecoration.image,
            isA<DecorationImage>(),
          );
          if (profilePicDecorationImageIsDecorationImage) {
            final profilePicDecorationImage =
                profilePicDecoration.image as DecorationImage;
            checkError(41, profilePicDecorationImage.fit, BoxFit.cover);
            bool profilePicDecorationImageIsNetworkImage = checkError(
              42,
              profilePicDecorationImage.image,
              isA<NetworkImage>(),
            );
            if (profilePicDecorationImageIsNetworkImage) {
              final profilePicDecorationImageNetworkImage =
                  profilePicDecorationImage.image as NetworkImage;
              checkError(
                43,
                profilePicDecorationImageNetworkImage.url,
                profile.profilePic!,
              );
            }
          }
        }
      }
    }
  });
  testWidgets("Check if profile informations is rendered correctly",
      (widgetTester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await mockNetworkImagesFor(
      () => widgetTester.pumpWidget(
        MaterialApp(
          home: ProfileInformation(profileStats: profile.stats!),
        ),
      ),
    );

    final profileInformationRowFinder = find.byKey(
      const Key('profile_information_row'),
    );
    bool profileInformationRowIsAvailable = checkError(
      44,
      profileInformationRowFinder,
      findsOneWidget,
    );
    if (profileInformationRowIsAvailable) {
      bool profileInformationRowIsRow = checkError(
          45, profileInformationRowFinder.evaluate().first.widget, isA<Row>());
      if (profileInformationRowIsRow) {
        final profileInformationRow =
            profileInformationRowFinder.evaluate().first.widget as Row;
        checkError(
            46, profileInformationRow.children.length, profile.stats!.length);
        checkError(
          47,
          profileInformationRow.mainAxisAlignment,
          MainAxisAlignment.spaceAround,
        );

        profile.stats!.asMap().forEach((index, value) {
          final profileInformationColumnFinder = find.byKey(
            Key('profile_information_column_$index'),
          );
          bool profileInformationColumnIsAvailable = checkError(
            48,
            profileInformationColumnFinder,
            findsOneWidget,
          );
          if (profileInformationColumnIsAvailable) {
            bool profileInformationColumnIsColumn = checkError(
              49,
              profileInformationColumnFinder.evaluate().first.widget,
              isA<Column>(),
            );
            if (profileInformationColumnIsColumn) {
              final profileInformationColumn = profileInformationColumnFinder
                  .evaluate()
                  .first
                  .widget as Column;
              checkError(50, profileInformationColumn.children.length, 2);

              final profileInformationAmountTextFinder = find.byKey(
                Key('profile_information_${index}_amount_text'),
              );
              bool profileInformationAmountTextIsAvailable = checkError(
                51,
                profileInformationAmountTextFinder,
                findsOneWidget,
              );
              if (profileInformationAmountTextIsAvailable) {
                bool profileInformationAmountTextIsText = checkError(
                  52,
                  profileInformationAmountTextFinder.evaluate().first.widget,
                  isA<Text>(),
                );
                if (profileInformationAmountTextIsText) {
                  final profileInformationAmountText =
                      profileInformationAmountTextFinder.evaluate().first.widget
                          as Text;
                  checkError(53, profileInformationAmountText.data,
                      profile.stats![index].count.toString());
                  checkError(
                    54,
                    profileInformationAmountText.style,
                    const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  );
                }
              }

              final profileInformationLabelTextFinder = find.byKey(
                Key('profile_information_${index}_label_text'),
              );
              bool profileInformationLabelTextIsAvailable = checkError(
                55,
                profileInformationLabelTextFinder,
                findsOneWidget,
              );
              if (profileInformationLabelTextIsAvailable) {
                bool profileInformationLabelTextIsText = checkError(
                  56,
                  profileInformationLabelTextFinder.evaluate().first.widget,
                  isA<Text>(),
                );
                if (profileInformationLabelTextIsText) {
                  final profileInformationLabelText =
                      profileInformationLabelTextFinder.evaluate().first.widget
                          as Text;
                  checkError(57, profileInformationLabelText.data,
                      profile.stats![index].label);
                  checkError(
                    58,
                    profileInformationLabelText.style,
                    const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  );
                }
              }
            }
          }
        });
      }
    }
  });
  testWidgets("Check if account's name is rendered correctly",
      (widgetTester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await mockNetworkImagesFor(
      () => widgetTester.pumpWidget(
        MaterialApp(
          home: AccountName(profile: profile),
        ),
      ),
    );

    final accountNameContainerFinder = find.byKey(
      const Key('account_name_container'),
    );
    bool accountNameContainerIsAvailable = checkError(
      59,
      accountNameContainerFinder,
      findsOneWidget,
    );
    if (accountNameContainerIsAvailable) {
      bool accountNameContainerIsContainer = checkError(
        60,
        accountNameContainerFinder.evaluate().first.widget,
        isA<Container>(),
      );
      if (accountNameContainerIsContainer) {
        final accountNameContainer =
            accountNameContainerFinder.evaluate().first.widget as Container;
        checkError(
          61,
          accountNameContainer.constraints!.widthConstraints(),
          const BoxConstraints(
              minWidth: double.infinity, maxWidth: double.infinity),
        );
        checkError(
          62,
          accountNameContainer.padding,
          const EdgeInsets.symmetric(horizontal: 15),
        );
        checkError(
          63,
          accountNameContainer.margin,
          const EdgeInsets.symmetric(vertical: 10),
        );

        final accountNameColumnFinder = find.byKey(
          const Key('account_name_column'),
        );
        bool accountNameColumnIsAvailable = checkError(
          64,
          find.descendant(
              of: accountNameContainerFinder,
              matching: accountNameColumnFinder),
          findsOneWidget,
        );

        if (accountNameColumnIsAvailable) {
          bool accountNameColumnIsColumn = checkError(
            65,
            accountNameColumnFinder.evaluate().first.widget,
            isA<Column>(),
          );

          if (accountNameColumnIsColumn) {
            final accountNameColumn =
                accountNameColumnFinder.evaluate().first.widget as Column;
            checkError(
              66,
              accountNameColumn.crossAxisAlignment,
              CrossAxisAlignment.start,
            );
            checkError(67, accountNameColumn.children.length, 2);

            final accountNameTextFinder = find.byKey(
              const Key('account_name_text'),
            );

            bool accountNameTextIsAvailable = checkError(
              68,
              find.descendant(
                  of: accountNameColumnFinder, matching: accountNameTextFinder),
              findsOneWidget,
            );

            if (accountNameTextIsAvailable) {
              bool accountNameTextIsText = checkError(
                69,
                accountNameTextFinder.evaluate().first.widget,
                isA<Text>(),
              );

              if (accountNameTextIsText) {
                final accountNameText =
                    accountNameTextFinder.evaluate().first.widget as Text;
                checkError(70, accountNameText.data, profile.name);
                checkError(
                  71,
                  accountNameText.style,
                  const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                );
              }
            }

            final accountBioText = find.byKey(const Key('account_bio_text'));
            bool accountBioTextIsAvailable = checkError(
              72,
              find.descendant(
                  of: accountNameColumnFinder, matching: accountBioText),
              findsOneWidget,
            );

            if (accountBioTextIsAvailable) {
              bool accountBioTextIsText = checkError(
                73,
                accountBioText.evaluate().first.widget,
                isA<Text>(),
              );

              if (accountBioTextIsText) {
                final accountBioTextWidget =
                    accountBioText.evaluate().first.widget as Text;
                checkError(74, accountBioTextWidget.data, profile.bio);
                checkError(
                  75,
                  accountBioTextWidget.style,
                  const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                );
              }
            }
          }
        }
      }
    }
  });
  testWidgets("Check if profile buttons is rendered correctly",
      (widgetTester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await mockNetworkImagesFor(
      () => widgetTester.pumpWidget(
        const MaterialApp(
          home: ProfileButtons(),
        ),
      ),
    );

    final profileButtonsPaddingFinder = find.byKey(
      const Key('profile_buttons_padding'),
    );

    bool accountPageProfileButtonsPaddingIsAvailable = checkError(
      76,
      profileButtonsPaddingFinder,
      findsOneWidget,
    );

    if (accountPageProfileButtonsPaddingIsAvailable) {
      bool accountPageProfileButtonsPaddingIsPadding = checkError(
        77,
        profileButtonsPaddingFinder.evaluate().first.widget,
        isA<Padding>(),
      );

      if (accountPageProfileButtonsPaddingIsPadding) {
        final accountPageProfileButtonsPadding =
            profileButtonsPaddingFinder.evaluate().first.widget as Padding;
        checkError(
          78,
          accountPageProfileButtonsPadding.padding,
          const EdgeInsets.symmetric(horizontal: 15),
        );

        final profileButtonsRowFinder =
            find.byKey(const Key('profile_buttons_row'));
        bool profileButtonsRowIsAvailable = checkError(
          79,
          find.descendant(
              of: profileButtonsPaddingFinder,
              matching: profileButtonsRowFinder),
          findsOneWidget,
        );

        if (profileButtonsRowIsAvailable) {
          bool profileButtonsRowIsRow = checkError(
            80,
            profileButtonsRowFinder.evaluate().first.widget,
            isA<Row>(),
          );

          if (profileButtonsRowIsRow) {
            final profileButtonsRow =
                profileButtonsRowFinder.evaluate().first.widget as Row;
            checkError(
              81,
              profileButtonsRow.mainAxisAlignment,
              MainAxisAlignment.spaceBetween,
            );
            checkError(82, profileButtonsRow.children.length, 5);

            final profileButtonsEditProfileButtonExpandedFinder = find.byKey(
              const Key('profile_buttons_edit_profile_button_expanded'),
            );
            bool profileButtonsEditProfileButtonExpandedIsAvailable =
                checkError(
              83,
              find.descendant(
                of: profileButtonsRowFinder,
                matching: profileButtonsEditProfileButtonExpandedFinder,
              ),
              findsOneWidget,
            );

            if (profileButtonsEditProfileButtonExpandedIsAvailable) {
              checkError(
                84,
                profileButtonsEditProfileButtonExpandedFinder
                    .evaluate()
                    .first
                    .widget,
                isA<Expanded>(),
              );

              final profileButtonsEditProfileButtonFinder = find.byKey(
                const Key('profile_buttons_edit_profile_button'),
              );
              bool profileButtonsEditProfileButtonIsAvailable = checkError(
                85,
                find.descendant(
                    of: profileButtonsEditProfileButtonExpandedFinder,
                    matching: profileButtonsEditProfileButtonFinder),
                findsOneWidget,
              );
              if (profileButtonsEditProfileButtonIsAvailable) {
                checkError(
                  86,
                  profileButtonsEditProfileButtonFinder.evaluate().first.widget,
                  isA<GreyButton>(),
                );

                final profileButtonsEditProfileButtonTextFinder = find.byKey(
                  const Key('profile_buttons_edit_profile_button_text'),
                );
                bool profileButtonsEditProfileButtonTextIsAvailable =
                    checkError(
                  87,
                  find.descendant(
                      of: profileButtonsEditProfileButtonFinder,
                      matching: profileButtonsEditProfileButtonTextFinder),
                  findsOneWidget,
                );
                if (profileButtonsEditProfileButtonTextIsAvailable) {
                  bool profileButtonsEditProfileButtonTextIsText = checkError(
                    88,
                    profileButtonsEditProfileButtonTextFinder
                        .evaluate()
                        .first
                        .widget,
                    isA<Text>(),
                  );
                  if (profileButtonsEditProfileButtonTextIsText) {
                    final profileButtonsEditProfileButtonText =
                        profileButtonsEditProfileButtonTextFinder
                            .evaluate()
                            .first
                            .widget as Text;
                    checkError(
                      89,
                      profileButtonsEditProfileButtonText.data,
                      'Edit Profile',
                    );
                    checkError(
                      90,
                      profileButtonsEditProfileButtonText.style,
                      const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    );
                  }
                }
              }
            }

            final profileButtonsShareProfileButtonExpandedFinder = find.byKey(
              const Key('profile_buttons_share_profile_button_expanded'),
            );
            bool profileButtonsShareProfileButtonExpandedIsAvailable =
                checkError(
              91,
              find.descendant(
                of: profileButtonsRowFinder,
                matching: profileButtonsShareProfileButtonExpandedFinder,
              ),
              findsOneWidget,
            );
            if (profileButtonsShareProfileButtonExpandedIsAvailable) {
              checkError(
                92,
                profileButtonsShareProfileButtonExpandedFinder
                    .evaluate()
                    .first
                    .widget,
                isA<Expanded>(),
              );

              final profileButtonsShareProfileButtonFinder = find.byKey(
                const Key('profile_buttons_share_profile_button'),
              );
              bool profileButtonsShareProfileButtonIsAvailable = checkError(
                93,
                find.descendant(
                    of: profileButtonsShareProfileButtonExpandedFinder,
                    matching: profileButtonsShareProfileButtonFinder),
                findsOneWidget,
              );
              if (profileButtonsShareProfileButtonIsAvailable) {
                checkError(
                  94,
                  profileButtonsShareProfileButtonFinder
                      .evaluate()
                      .first
                      .widget,
                  isA<GreyButton>(),
                );

                final profileButtonsShareProfileButtonTextFinder = find.byKey(
                  const Key('profile_buttons_share_profile_button_text'),
                );
                bool profileButtonsShareProfileButtonTextIsAvailable =
                    checkError(
                  95,
                  find.descendant(
                      of: profileButtonsShareProfileButtonFinder,
                      matching: profileButtonsShareProfileButtonTextFinder),
                  findsOneWidget,
                );
                if (profileButtonsShareProfileButtonTextIsAvailable) {
                  bool profileButtonsShareProfileButtonTextIsText = checkError(
                    96,
                    profileButtonsShareProfileButtonTextFinder
                        .evaluate()
                        .first
                        .widget,
                    isA<Text>(),
                  );
                  if (profileButtonsShareProfileButtonTextIsText) {
                    final profileButtonsShareProfileButtonText =
                        profileButtonsShareProfileButtonTextFinder
                            .evaluate()
                            .first
                            .widget as Text;
                    checkError(
                      97,
                      profileButtonsShareProfileButtonText.data,
                      'Share profile',
                    );
                    checkError(
                      98,
                      profileButtonsShareProfileButtonText.style,
                      const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    );
                  }
                }
              }
            }

            final profileButtonsDiscoverPeopleButtonFinder = find.byKey(
              const Key('profile_buttons_discover_people_button'),
            );
            bool profileButtonsDiscoverPeopleButtonIsAvailable = checkError(
              99,
              find.descendant(
                  of: profileButtonsRowFinder,
                  matching: profileButtonsDiscoverPeopleButtonFinder),
              findsOneWidget,
            );
            if (profileButtonsDiscoverPeopleButtonIsAvailable) {
              checkError(
                100,
                profileButtonsDiscoverPeopleButtonFinder
                    .evaluate()
                    .first
                    .widget,
                isA<GreyButton>(),
              );

              final profileButtonsDiscoverPeopleIconFinder = find.byKey(
                const Key('profile_buttons_discover_people_icon'),
              );
              bool profileButtonsDiscoverPeopleIconIsAvailable = checkError(
                101,
                find.descendant(
                    of: profileButtonsDiscoverPeopleButtonFinder,
                    matching: profileButtonsDiscoverPeopleIconFinder),
                findsOneWidget,
              );
              if (profileButtonsDiscoverPeopleIconIsAvailable) {
                bool profileButtonsDiscoverPeopleIconIsIcon = checkError(
                  102,
                  profileButtonsDiscoverPeopleIconFinder
                      .evaluate()
                      .first
                      .widget,
                  isA<Icon>(),
                );
                if (profileButtonsDiscoverPeopleIconIsIcon) {
                  final profileButtonsDiscoverPeopleIcon =
                      profileButtonsDiscoverPeopleIconFinder
                          .evaluate()
                          .first
                          .widget as Icon;
                  checkError(
                    103,
                    profileButtonsDiscoverPeopleIcon.icon,
                    Icons.person_add_outlined,
                  );
                  checkError(
                    104,
                    profileButtonsDiscoverPeopleIcon.color,
                    Colors.white,
                  );
                }
              }
            }
          }
        }
      }
    }
  });
  testWidgets("Check if Grey buttons is rendered correctly",
      (widgetTester) async {
    FlutterError.onError = ignoreOverflowErrors;
    const mockKey = Key('grey_button');
    const mockWidget = Text('Grey Button');

    await mockNetworkImagesFor(
      () => widgetTester.pumpWidget(
        MaterialApp(
          home: GreyButton(
            key: mockKey,
            onPressed: () {},
            child: mockWidget,
          ),
        ),
      ),
    );

    final greyButtonElevatedButtonFinder = find.byKey(
      Key('${mockKey}_elevated_button'),
    );
    bool greyButtonElevatedButtonIsAvailable = checkError(
      105,
      greyButtonElevatedButtonFinder,
      findsOneWidget,
    );
    if (greyButtonElevatedButtonIsAvailable) {
      bool greyButtonElevatedButtonIsElevatedButton = checkError(
        106,
        greyButtonElevatedButtonFinder.evaluate().first.widget,
        isA<ElevatedButton>(),
      );
      if (greyButtonElevatedButtonIsElevatedButton) {
        final greyButtonElevatedButton = greyButtonElevatedButtonFinder
            .evaluate()
            .first
            .widget as ElevatedButton;
        try {
          checkError(
            107,
            greyButtonElevatedButton.style!.backgroundColor!.resolve(states),
            Colors.grey[800],
          );
        } catch (e) {
          debugPrint(
            "Account Page Test-107 failed: backgroundColor is not set",
          );
        }

        try {
          checkError(
            108,
            greyButtonElevatedButton.style!.minimumSize!.resolve(states),
            const Size(0, 30),
          );
        } catch (e) {
          debugPrint(
            "Account Page Test-108 failed: minimumSize is not set",
          );
        }

        try {
          checkError(
            109,
            greyButtonElevatedButton.style!.shape!.resolve(states),
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          );
        } catch (e) {
          debugPrint(
            "Account Page Test-109 failed: shape is not set",
          );
        }
      }
    }
  });
  testWidgets("Check if Highlight list is rendered correctly",
      (widgetTester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await mockNetworkImagesFor(
      () => widgetTester.pumpWidget(
        MaterialApp(
          home: HighlightList(stories: stories),
        ),
      ),
    );

    final highlightListScrollViewFinder = find.byKey(
      const Key('highlight_list_scroll_view'),
    );

    bool highlightListScrollViewIsAvailable = checkError(
      110,
      highlightListScrollViewFinder,
      findsOneWidget,
    );

    if (highlightListScrollViewIsAvailable) {
      bool highlightListScrollViewIsScrollView = checkError(
        111,
        highlightListScrollViewFinder.evaluate().first.widget,
        isA<SingleChildScrollView>(),
      );
      if (highlightListScrollViewIsScrollView) {
        final highlightListScrollView = highlightListScrollViewFinder
            .evaluate()
            .first
            .widget as SingleChildScrollView;
        checkError(
          112,
          highlightListScrollView.scrollDirection,
          Axis.horizontal,
        );
        checkError(
          113,
          highlightListScrollView.padding,
          const EdgeInsets.only(left: 15, top: 10, bottom: 10),
        );
      }
      final highlightListParentRowFinder = find.byKey(
        const Key("highlight_list_parent_row"),
      );
      bool highlightListParentRowIsAvailable = checkError(
        114,
        find.descendant(
          of: highlightListScrollViewFinder,
          matching: highlightListParentRowFinder,
        ),
        findsOneWidget,
      );
      if (highlightListParentRowIsAvailable) {
        checkError(
          115,
          highlightListParentRowFinder.evaluate().first.widget,
          isA<Row>(),
        );
        final highlightListChildRowFinder = find.byKey(
          const Key("highlight_list_child_row"),
        );
        bool highlightListChildRowIsAvailable = checkError(
          116,
          find.descendant(
            of: highlightListParentRowFinder,
            matching: highlightListChildRowFinder,
          ),
          findsOneWidget,
        );
        if (highlightListChildRowIsAvailable) {
          bool highlightListChildRowIsRow = checkError(
            117,
            highlightListChildRowFinder.evaluate().first.widget,
            isA<Row>(),
          );
          if (highlightListChildRowIsRow) {
            final highlightListChildRow =
                highlightListChildRowFinder.evaluate().first.widget as Row;
            bool highlightItemsFinder = checkError(
              118,
              highlightListChildRow.children.length,
              stories.length,
            );

            if (highlightItemsFinder) {
              stories.asMap().forEach((key, value) {
                final highlightItemFinder = find.byKey(
                  Key("highlight_item_$key"),
                );
                bool highlightItemIsAvailable = checkError(
                  119,
                  find.descendant(
                    of: highlightListChildRowFinder,
                    matching: highlightItemFinder,
                  ),
                  findsOneWidget,
                );

                if (highlightItemIsAvailable) {
                  bool highlightItemIsHighlightItem = checkError(
                    120,
                    highlightItemFinder.evaluate().first.widget,
                    isA<HighlightItem>(),
                  );
                  if (highlightItemIsHighlightItem) {
                    final highlightItem = highlightItemFinder
                        .evaluate()
                        .first
                        .widget as HighlightItem;
                    checkError(
                      121,
                      highlightItem.img,
                      value["img"],
                    );
                    checkError(
                      122,
                      highlightItem.name,
                      value["name"],
                    );
                  }
                }
              });
            }
          }
        }

        final highightListAddHighlightFinder = find.byKey(
          const Key("highlight_list_add_highlight"),
        );
        bool highightAddHighlightIsAvailable = checkError(
          123,
          find.descendant(
            of: highlightListParentRowFinder,
            matching: highightListAddHighlightFinder,
          ),
          findsOneWidget,
        );

        if (highightAddHighlightIsAvailable) {
          bool highightAddHighlightIsPadding = checkError(
            124,
            highightListAddHighlightFinder.evaluate().first.widget,
            isA<Padding>(),
          );
          if (highightAddHighlightIsPadding) {
            final highightAddHighlight = highightListAddHighlightFinder
                .evaluate()
                .first
                .widget as Padding;
            checkError(
              125,
              highightAddHighlight.padding,
              const EdgeInsets.only(right: 10, bottom: 10),
            );
          }

          final highlightListAddHighlightColumnFinder = find.byKey(
            const Key("highlight_list_add_highlight_column"),
          );
          bool highlightListAddHighlightColumnIsAvailable = checkError(
            126,
            find.descendant(
              of: highightListAddHighlightFinder,
              matching: highlightListAddHighlightColumnFinder,
            ),
            findsOneWidget,
          );
          if (highlightListAddHighlightColumnIsAvailable) {
            bool highlightListAddHighlightColumnIsColumn = checkError(
              127,
              highlightListAddHighlightColumnFinder.evaluate().first.widget,
              isA<Column>(),
            );
            if (highlightListAddHighlightColumnIsColumn) {
              final highlightListAddHighlightColumn =
                  highlightListAddHighlightColumnFinder.evaluate().first.widget
                      as Column;
              checkError(
                129,
                highlightListAddHighlightColumn.children.length,
                2,
              );
              // final highlightListAddHighlightIconFinder = find.byKey(
              //   const Key("highlight_list_add_highlight_icon"),
              // );
              // bool highlightListAddHighlightIconIsAvailable = checkError(
              //   130,
              //   find.descendant(
              //     of: highlightListAddHighlightColumnFinder,
              //     matching: highlightListAddHighlightIconFinder,
              //   ),
              //   findsOneWidget,
              // );
              // if (highlightListAddHighlightIconIsAvailable) {
              //   bool highlightListAddHighlightIconIsIcon = checkError(
              //     131,
              //     highlightListAddHighlightIconFinder.evaluate().first.widget,
              //     isA<Icon>(),
              //   );
              //   if (highlightListAddHighlightIconIsIcon) {
              //     final highlightListAddHighlightIcon =
              //         highlightListAddHighlightIconFinder
              //             .evaluate()
              //             .first
              //             .widget as Icon;
              //     checkError(
              //       132,
              //       highlightListAddHighlightIcon.icon,
              //       Icons.add,
              //     );
              //     checkError(
              //       133,
              //       highlightListAddHighlightIcon.color,
              //       Colors.white,
              //     );
              //   }
              // }
              // final highlightListAddHighlightTextFinder = find.byKey(
              //   const Key("highlight_list_add_highlight_text"),
              // );
              // bool highlightListAddHighlightTextIsAvailable = checkError(
              //   134,
              //   find.descendant(
              //     of: highlightListAddHighlightColumnFinder,
              //     matching: highlightListAddHighlightTextFinder,
              //   ),
              //   findsOneWidget,
              // );
              // if (highlightListAddHighlightTextIsAvailable) {
              //   bool highlightListAddHighlightTextIsText = checkError(
              //     135,
              //     highlightListAddHighlightTextFinder.evaluate().first.widget,
              //     isA<Text>(),
              //   );
              //   if (highlightListAddHighlightTextIsText) {
              //     final highlightListAddHighlightText =
              //         highlightListAddHighlightTextFinder
              //             .evaluate()
              //             .first
              //             .widget as Text;
              //     checkError(
              //       136,
              //       highlightListAddHighlightText.data,
              //       "New",
              //     );
              //   }
              // }
            }

            final highlightListAddHighlightContainerFinder = find.byKey(
              const Key("highlight_list_add_highlight_container"),
            );
            bool highlightAddHighlightContainerIsAvailable = checkError(
              137,
              find.descendant(
                of: highlightListAddHighlightColumnFinder,
                matching: highlightListAddHighlightContainerFinder,
              ),
              findsOneWidget,
            );
            if (highlightAddHighlightContainerIsAvailable) {
              bool highlightAddHighlightContainerIsContainer = checkError(
                138,
                highlightListAddHighlightContainerFinder
                    .evaluate()
                    .first
                    .widget,
                isA<Container>(),
              );
              if (highlightAddHighlightContainerIsContainer) {
                final highlightAddHighlightContainer =
                    highlightListAddHighlightContainerFinder
                        .evaluate()
                        .first
                        .widget as Container;
                checkError(
                  139,
                  highlightAddHighlightContainer.padding,
                  const EdgeInsets.all(3),
                );
                checkError(
                  140,
                  highlightAddHighlightContainer.margin,
                  const EdgeInsets.only(bottom: 8),
                );
                checkError(
                  141,
                  highlightAddHighlightContainer.constraints!
                      .widthConstraints(),
                  const BoxConstraints(minWidth: 68, maxWidth: 68),
                );
                checkError(
                  142,
                  highlightAddHighlightContainer.constraints!
                      .heightConstraints(),
                  const BoxConstraints(minHeight: 68, maxHeight: 68),
                );

                bool highlightAddHighlightContainerDecorationBoxDecoration =
                    checkError(
                  143,
                  highlightAddHighlightContainer.decoration,
                  isA<BoxDecoration>(),
                );
                if (highlightAddHighlightContainerDecorationBoxDecoration) {
                  final highlightAddHighlightContainerDecoration =
                      highlightAddHighlightContainer.decoration
                          as BoxDecoration;
                  checkError(
                      144,
                      highlightAddHighlightContainerDecoration.shape,
                      BoxShape.circle);
                  checkError(
                    145,
                    highlightAddHighlightContainerDecoration.border,
                    Border.all(color: Colors.white, width: 1),
                  );
                }
              }

              final highlightListAddHighlightIconContainerFinder = find.byKey(
                const Key("highlight_list_add_highlight_icon_container"),
              );

              bool highlightListAddHighlightIconContainerIsAvailable =
                  checkError(
                146,
                find.descendant(
                  of: highlightListAddHighlightContainerFinder,
                  matching: highlightListAddHighlightIconContainerFinder,
                ),
                findsOneWidget,
              );
              if (highlightListAddHighlightIconContainerIsAvailable) {
                bool highlightListAddHighlightIconContainerIsContainer =
                    checkError(
                  147,
                  highlightListAddHighlightIconContainerFinder
                      .evaluate()
                      .first
                      .widget,
                  isA<Container>(),
                );
                if (highlightListAddHighlightIconContainerIsContainer) {
                  final highlightListAddHighlightIconContainer =
                      highlightListAddHighlightIconContainerFinder
                          .evaluate()
                          .first
                          .widget as Container;
                  bool highlightListAddHighlightIconContainerIsBoxDecoration =
                      checkError(
                    148,
                    highlightListAddHighlightIconContainer.decoration,
                    isA<BoxDecoration>(),
                  );
                  if (highlightListAddHighlightIconContainerIsBoxDecoration) {
                    final highlightListAddHighlightIconContainerDecoration =
                        highlightListAddHighlightIconContainer.decoration
                            as BoxDecoration;
                    checkError(
                      149,
                      highlightListAddHighlightIconContainerDecoration.shape,
                      BoxShape.circle,
                    );
                    checkError(
                      150,
                      highlightListAddHighlightIconContainerDecoration.border,
                      Border.all(color: Colors.black, width: 2),
                    );
                  }
                }

                final highlightListAddHighlightIconFinder = find.byKey(
                  const Key("highlight_list_add_highlight_icon"),
                );
                bool highlightListAddHighlightIconIsAvailable = checkError(
                  151,
                  find.descendant(
                    of: highlightListAddHighlightIconContainerFinder,
                    matching: highlightListAddHighlightIconFinder,
                  ),
                  findsOneWidget,
                );

                if (highlightListAddHighlightIconIsAvailable) {
                  bool highlightListAddHighlightIconIsIcon = checkError(
                    152,
                    highlightListAddHighlightIconFinder.evaluate().first.widget,
                    isA<Icon>(),
                  );
                  if (highlightListAddHighlightIconIsIcon) {
                    final highlightListAddHighlightIcon =
                        highlightListAddHighlightIconFinder
                            .evaluate()
                            .first
                            .widget as Icon;
                    checkError(
                      153,
                      highlightListAddHighlightIcon.icon,
                      Icons.add,
                    );
                    checkError(
                      154,
                      highlightListAddHighlightIcon.color,
                      Colors.white,
                    );
                  }
                }
              }
            }

            final highlightListAddHighlightTextSizedBoxFinder = find.byKey(
              const Key("highlight_list_add_highlight_text_sized_box"),
            );
            bool highlightListAddHighlightTextSizedBoxIsAvailable = checkError(
              155,
              find.descendant(
                of: highlightListAddHighlightColumnFinder,
                matching: highlightListAddHighlightTextSizedBoxFinder,
              ),
              findsOneWidget,
            );

            if (highlightListAddHighlightTextSizedBoxIsAvailable) {
              bool highlightListAddHighlightTextSizedBoxIsSizedBox = checkError(
                156,
                highlightListAddHighlightTextSizedBoxFinder
                    .evaluate()
                    .first
                    .widget,
                isA<SizedBox>(),
              );
              if (highlightListAddHighlightTextSizedBoxIsSizedBox) {
                final highlightListAddHighlightTextSizedBox =
                    highlightListAddHighlightTextSizedBoxFinder
                        .evaluate()
                        .first
                        .widget as SizedBox;
                checkError(
                    157, highlightListAddHighlightTextSizedBox.width, 70);
              }

              final highlightListAddHighlightTextFinder = find.byKey(
                const Key("highlight_list_add_highlight_text"),
              );
              bool highlightListAddHighlightTextIsAvailable = checkError(
                158,
                find.descendant(
                  of: highlightListAddHighlightTextSizedBoxFinder,
                  matching: highlightListAddHighlightTextFinder,
                ),
                findsOneWidget,
              );

              if (highlightListAddHighlightTextIsAvailable) {
                bool highlightListAddHighlightTextIsText = checkError(
                  159,
                  highlightListAddHighlightTextFinder.evaluate().first.widget,
                  isA<Text>(),
                );
                if (highlightListAddHighlightTextIsText) {
                  final highlightListAddHighlightText =
                      highlightListAddHighlightTextFinder
                          .evaluate()
                          .first
                          .widget as Text;
                  checkError(160, highlightListAddHighlightText.data, "New");
                  checkError(
                    161,
                    highlightListAddHighlightText.overflow,
                    TextOverflow.ellipsis,
                  );
                  checkError(
                    162,
                    highlightListAddHighlightText.textAlign,
                    TextAlign.center,
                  );
                  bool highlightListAddHighlightTextIsTextStyle = checkError(
                    163,
                    highlightListAddHighlightText.style,
                    isA<TextStyle>(),
                  );
                  if (highlightListAddHighlightTextIsTextStyle) {
                    final highlightListAddHighlightTextStyle =
                        highlightListAddHighlightText.style as TextStyle;
                    checkError(
                      164,
                      highlightListAddHighlightTextStyle.color,
                      Colors.white,
                    );
                  }
                }
              }
            }
          }
        }
      }
    }
  });
  testWidgets("Check if Highlight Item is rendered correctly",
      (widgetTester) async {
    FlutterError.onError = ignoreOverflowErrors;
    final img = stories[0]["img"];
    final name = stories[0]["name"];
    await widgetTester.pumpWidget(
      MaterialApp(
        home: HighlightItem(
          img: img,
          name: name,
        ),
      ),
    );

    final highlightItemPaddingFinder = find.byKey(
      const Key("highlight_item_padding"),
    );
    bool highlightItemPaddingIsAvailable = checkError(
      165,
      find.descendant(
        of: find.byType(HighlightItem),
        matching: highlightItemPaddingFinder,
      ),
      findsOneWidget,
    );

    if (highlightItemPaddingIsAvailable) {
      bool highlightItemPaddingIsPadding = checkError(
        166,
        highlightItemPaddingFinder.evaluate().first.widget,
        isA<Padding>(),
      );
      if (highlightItemPaddingIsPadding) {
        final highlightItemPadding =
            highlightItemPaddingFinder.evaluate().first.widget as Padding;
        checkError(
          167,
          highlightItemPadding.padding,
          const EdgeInsets.only(right: 10, bottom: 10),
        );
      }
      final highlightItemColumnFinder = find.byKey(
        const Key("highlight_item_column"),
      );
      bool highlightItemColumnIsAvailable = checkError(
        168,
        find.descendant(
          of: highlightItemPaddingFinder,
          matching: highlightItemColumnFinder,
        ),
        findsOneWidget,
      );

      if (highlightItemColumnIsAvailable) {
        bool highlightItemColumnIsColumn = checkError(
          169,
          highlightItemColumnFinder.evaluate().first.widget,
          isA<Column>(),
        );
        if (highlightItemColumnIsColumn) {
          final highlightItemColumn =
              highlightItemColumnFinder.evaluate().first.widget as Column;
          checkError(170, highlightItemColumn.children.length, 2);
        }

        final highlightItemContainerFinder = find.byKey(
          const Key("highlight_item_container"),
        );
        bool highlightItemContainerIsAvailable = checkError(
          171,
          find.descendant(
            of: highlightItemColumnFinder,
            matching: highlightItemContainerFinder,
          ),
          findsOneWidget,
        );
        if (highlightItemContainerIsAvailable) {
          bool highlightItemContainerIsContainer = checkError(
            172,
            highlightItemContainerFinder.evaluate().first.widget,
            isA<Container>(),
          );
          if (highlightItemContainerIsContainer) {
            final highlightItemContainer = highlightItemContainerFinder
                .evaluate()
                .first
                .widget as Container;
            checkError(
              173,
              highlightItemContainer.constraints!.widthConstraints(),
              const BoxConstraints(minWidth: 68, maxWidth: 68),
            );
            checkError(
              174,
              highlightItemContainer.constraints!.heightConstraints(),
              const BoxConstraints(minHeight: 68, maxHeight: 68),
            );
            checkError(
              175,
              highlightItemContainer.padding,
              const EdgeInsets.all(3.0),
            );
            checkError(
              176,
              highlightItemContainer.margin,
              const EdgeInsets.only(bottom: 8),
            );

            bool highlightItemContainerDecorationIsBoxDecoration = checkError(
              177,
              highlightItemContainer.decoration,
              isA<BoxDecoration>(),
            );

            if (highlightItemContainerDecorationIsBoxDecoration) {
              final highlightItemContainerDecoration =
                  highlightItemContainer.decoration as BoxDecoration;
              checkError(
                  178, highlightItemContainerDecoration.shape, BoxShape.circle);
              checkError(
                179,
                highlightItemContainerDecoration.border,
                Border.all(color: Colors.grey[800]!, width: 1),
              );
            }
          }
        }
        final highlightItemImageContainerFinder = find.byKey(
          const Key("highlight_item_image_container"),
        );
        bool highlightItemImageContainerIsAvailable = checkError(
          180,
          find.descendant(
            of: highlightItemContainerFinder,
            matching: highlightItemImageContainerFinder,
          ),
          findsOneWidget,
        );
        if (highlightItemImageContainerIsAvailable) {
          bool highlightItemImageContainerIsContainer = checkError(
            181,
            highlightItemImageContainerFinder.evaluate().first.widget,
            isA<Container>(),
          );
          if (highlightItemImageContainerIsContainer) {
            final highlightItemImageContainer =
                highlightItemImageContainerFinder.evaluate().first.widget
                    as Container;
            bool highlightItemImageContainerDecorationIsBoxDecoration =
                checkError(182, highlightItemImageContainer.decoration,
                    isA<BoxDecoration>());
            if (highlightItemImageContainerDecorationIsBoxDecoration) {
              final highlightItemImageContainerDecoration =
                  highlightItemImageContainer.decoration as BoxDecoration;
              checkError(183, highlightItemImageContainerDecoration.shape,
                  BoxShape.circle);
              checkError(
                184,
                highlightItemImageContainerDecoration.border,
                Border.all(color: Colors.black, width: 2),
              );
              bool highlightItemImageContainerDecorationImageIsDecorationImage =
                  checkError(
                185,
                highlightItemImageContainerDecoration.image,
                isA<DecorationImage>(),
              );

              if (highlightItemImageContainerDecorationImageIsDecorationImage) {
                final highlightItemImageContainerDecorationImage =
                    highlightItemImageContainerDecoration.image
                        as DecorationImage;
                checkError(186, highlightItemImageContainerDecorationImage.fit,
                    BoxFit.cover);
                bool highlightItemImageContainerDecorationImageIsNetworkImage =
                    checkError(
                  187,
                  highlightItemImageContainerDecorationImage.image,
                  isA<NetworkImage>(),
                );

                if (highlightItemImageContainerDecorationImageIsNetworkImage) {
                  final highlightItemImageContainerDecorationImageNetworkImage =
                      highlightItemImageContainerDecorationImage.image
                          as NetworkImage;
                  checkError(
                    188,
                    highlightItemImageContainerDecorationImageNetworkImage.url,
                    img,
                  );
                }
              }
            }
          }
        }

        final highlightItemTextSizedBoxFinder = find.byKey(
          const Key("highlight_item_text_sized_box"),
        );
        bool highlightItemTextSizedBoxIsAvailable = checkError(
          189,
          find.descendant(
            of: highlightItemColumnFinder,
            matching: highlightItemTextSizedBoxFinder,
          ),
          findsOneWidget,
        );

        if (highlightItemTextSizedBoxIsAvailable) {
          bool highlightItemTextSizedBoxIsSizedBox = checkError(
            190,
            highlightItemTextSizedBoxFinder.evaluate().first.widget,
            isA<SizedBox>(),
          );
          if (highlightItemTextSizedBoxIsSizedBox) {
            final highlightItemTextSizedBox = highlightItemTextSizedBoxFinder
                .evaluate()
                .first
                .widget as SizedBox;
            checkError(191, highlightItemTextSizedBox.width, 70);
          }
          final highlightItemTextFinder = find.byKey(
            const Key("highlight_item_text"),
          );
          bool highlightItemTextIsAvailable = checkError(
            192,
            find.descendant(
              of: highlightItemTextSizedBoxFinder,
              matching: highlightItemTextFinder,
            ),
            findsOneWidget,
          );
          if (highlightItemTextIsAvailable) {
            bool highlightItemTextIsText = checkError(
              193,
              highlightItemTextFinder.evaluate().first.widget,
              isA<Text>(),
            );
            if (highlightItemTextIsText) {
              final highlightItemText =
                  highlightItemTextFinder.evaluate().first.widget as Text;
              checkError(
                  194, highlightItemText.overflow, TextOverflow.ellipsis);
              checkError(195, highlightItemText.textAlign, TextAlign.center);
              bool highlightItemTextIsTextStyle = checkError(
                196,
                highlightItemText.style,
                isA<TextStyle>(),
              );
              if (highlightItemTextIsTextStyle) {
                final highlightItemTextStyle =
                    highlightItemText.style as TextStyle;
                checkError(197, highlightItemTextStyle.color, Colors.white);
              }
              checkError(198, highlightItemText.data, name);
            }
          }
        }
      }
    }
  });
  testWidgets("Check if Account tab is rendered correctly",
      (widgetTester) async {
    FlutterError.onError = ignoreOverflowErrors;
    const pageIndex = 0;

    await mockNetworkImagesFor(
      () => widgetTester.pumpWidget(
        MaterialApp(
          home: AccountTab(
            pageIndex: pageIndex,
            updateIndex: (updateIndex) {},
          ),
        ),
      ),
    );

    final accountTabRowFinder = find.byKey(
      const Key("account_tab_row"),
    );
    bool accountTabRowIsAvailable = checkError(
      199,
      accountTabRowFinder,
      findsOneWidget,
    );
    if (accountTabRowIsAvailable) {
      bool accountTabRowIsRow = checkError(
        200,
        accountTabRowFinder.evaluate().first.widget,
        isA<Row>(),
      );
      if (accountTabRowIsRow) {
        final accountTabRow =
            accountTabRowFinder.evaluate().first.widget as Row;
        checkError(201, accountTabRow.children.length, tabs.length);
      }

      tabs.asMap().forEach((key, value) {
        final accountTabDecoratedBoxFinder = find.byKey(
          Key("account_tab_decorated_box_$key"),
        );
        bool accountTabDecoratedBoxIsAvailable = checkError(
          202,
          find.descendant(
            of: accountTabRowFinder,
            matching: accountTabDecoratedBoxFinder,
          ),
          findsOneWidget,
        );

        if (accountTabDecoratedBoxIsAvailable) {
          bool accountTabDecoratedBoxIsDecoratedBox = checkError(
            203,
            accountTabDecoratedBoxFinder.evaluate().first.widget,
            isA<DecoratedBox>(),
          );
          if (accountTabDecoratedBoxIsDecoratedBox) {
            final accountTabDecoratedBox = accountTabDecoratedBoxFinder
                .evaluate()
                .first
                .widget as DecoratedBox;
            bool accountTabDecoratedBoxDecorationIsBoxDecoration = checkError(
              204,
              accountTabDecoratedBox.decoration,
              isA<BoxDecoration>(),
            );
            if (accountTabDecoratedBoxDecorationIsBoxDecoration) {
              final accountTabDecoratedBoxDecoration =
                  accountTabDecoratedBox.decoration as BoxDecoration;
              bool accountTabDecoratedBoxDecorationBorderIsBorder = checkError(
                205,
                accountTabDecoratedBoxDecoration.border,
                isA<Border>(),
              );
              if (accountTabDecoratedBoxDecorationBorderIsBorder) {
                final accountTabDecoratedBoxDecorationBorder =
                    accountTabDecoratedBoxDecoration.border as Border;
                bool accountTabDecoratedBoxDecorationBorderBottomIsBorderSide =
                    checkError(
                  206,
                  accountTabDecoratedBoxDecorationBorder.bottom,
                  isA<BorderSide>(),
                );
                if (accountTabDecoratedBoxDecorationBorderBottomIsBorderSide) {
                  final accountTabDecoratedBoxDecorationBorderBottom =
                      accountTabDecoratedBoxDecorationBorder.bottom;
                  checkError(
                    207,
                    accountTabDecoratedBoxDecorationBorderBottom.color,
                    (pageIndex == key) ? Colors.white : Colors.transparent,
                  );
                  checkError(
                    208,
                    accountTabDecoratedBoxDecorationBorderBottom.width,
                    2,
                  );
                }
              }
            }
          }
          final accountTabElevatedButtonFinder = find.byKey(
            Key("account_tab_elevated_button_$key"),
          );
          bool accountTabElevatedButtonIsAvailable = checkError(
            209,
            find.descendant(
              of: accountTabDecoratedBoxFinder,
              matching: accountTabElevatedButtonFinder,
            ),
            findsOneWidget,
          );
          if (accountTabElevatedButtonIsAvailable) {
            bool accountTabElevatedButtonIsElevatedButton = checkError(
              210,
              accountTabElevatedButtonFinder.evaluate().first.widget,
              isA<ElevatedButton>(),
            );
            if (accountTabElevatedButtonIsElevatedButton) {
              final accountTabElevatedButton = accountTabElevatedButtonFinder
                  .evaluate()
                  .first
                  .widget as ElevatedButton;
              bool accountTabElevatedButtonStyleIsButtonStyle = checkError(
                211,
                accountTabElevatedButton.style,
                isA<ButtonStyle>(),
              );
              if (accountTabElevatedButtonStyleIsButtonStyle) {
                final accountTabElevatedButtonStyle =
                    accountTabElevatedButton.style as ButtonStyle;
                checkError(
                  212,
                  accountTabElevatedButtonStyle.backgroundColor!
                      .resolve(states),
                  Colors.transparent,
                );
                checkError(
                  213,
                  accountTabElevatedButtonStyle.elevation!.resolve(states),
                  0,
                );
              }
            }
            final accountTabIconFinder = find.byKey(
              Key("account_tab_icon_$key"),
            );
            bool accountTabIconIsAvailable = checkError(
              214,
              find.descendant(
                of: accountTabElevatedButtonFinder,
                matching: accountTabIconFinder,
              ),
              findsOneWidget,
            );
            if (accountTabIconIsAvailable) {
              bool accountTabIconIsIcon = checkError(
                215,
                accountTabIconFinder.evaluate().first.widget,
                isA<Icon>(),
              );
              if (accountTabIconIsIcon) {
                final accountTabIcon =
                    accountTabIconFinder.evaluate().first.widget as Icon;
                checkError(216, accountTabIcon.color, Colors.white);
                checkError(217, accountTabIcon.icon, tabs[key]['icon']);
              }
            }
          }
        }
      });
    }
  });
  testWidgets('Check if Account posts thumbnail is present',
      (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;
    const String imageUrl = "https://picsum.photos/250?image=9";
    // mock screen size
    tester.binding.window.physicalSizeTestValue = const Size(375, 812);
    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        const MaterialApp(
          home: PostThumbnail(imageUrl: imageUrl),
        ),
      ),
    );

    final postThumbnailContainerFinder = find.byKey(
      const Key(imageUrl),
    );
    checkError(218, postThumbnailContainerFinder, findsOneWidget);

    final postThumbnailContainer =
        postThumbnailContainerFinder.evaluate().single.widget as Container;
    checkError(219, postThumbnailContainer.decoration, isA<BoxDecoration>());

    final postThumbnailContainerDecoration =
        postThumbnailContainer.decoration as BoxDecoration;
    checkError(
      220,
      postThumbnailContainerDecoration.image,
      isA<DecorationImage>(),
    );

    final postThumbnailContainerDecorationImage =
        postThumbnailContainerDecoration.image as DecorationImage;
    checkError(
      221,
      postThumbnailContainerDecorationImage.image,
      isA<NetworkImage>(),
    );
    checkError(
      222,
      postThumbnailContainerDecorationImage.fit,
      BoxFit.cover,
    );

    final postThumbnailContainerDecorationImageNetworkImage =
        postThumbnailContainerDecorationImage.image as NetworkImage;
    checkError(
      223,
      postThumbnailContainerDecorationImageNetworkImage.url,
      imageUrl,
    );
  });

  testWidgets('Check if Bottom Navbar is present', (WidgetTester tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        MaterialApp(
          home: AccountPage(
            posts: posts,
            stories: stories,
            profileData: profileJson,
          ),
        ),
      ),
    );

    int pageIndex = 4;

    List bottomItems = [
      pageIndex == 0
          ? "assets/images/home_active_icon.svg"
          : "assets/images/home_icon.svg",
      pageIndex == 1
          ? "assets/images/search_active_icon.svg"
          : "assets/images/search_icon.svg",
      pageIndex == 2
          ? "assets/images/upload_active_icon.svg"
          : "assets/images/upload_icon.svg",
      pageIndex == 3
          ? "assets/images/love_active_icon.svg"
          : "assets/images/love_icon.svg",
      pageIndex == 4
          ? "assets/images/account_active_icon.svg"
          : "assets/images/account_icon.svg",
    ];

    final bottomNavigationBarContainer =
        find.byKey(const Key('bottom_navigation_bar_container'));
    checkError(224, bottomNavigationBarContainer, findsOneWidget);

    final bottomNavigationBarContainerFinder =
        bottomNavigationBarContainer.evaluate().first.widget as Container;
    checkError(
        225, bottomNavigationBarContainerFinder.constraints!.maxHeight, 55);
    checkError(226, bottomNavigationBarContainerFinder.constraints!.maxWidth,
        double.infinity);
    checkError(227, bottomNavigationBarContainerFinder.color, Colors.black);
    checkError(228, bottomNavigationBarContainerFinder.padding,
        const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 15));

    final bottomNavigationBarRowFinder =
        find.byKey(const Key('bottom_navigation_bar_row'));
    checkError(
        229,
        find.descendant(
            of: bottomNavigationBarContainer,
            matching: bottomNavigationBarRowFinder),
        findsOneWidget);

    final bottomNavigationBarRow =
        bottomNavigationBarRowFinder.evaluate().first.widget as Row;
    checkError(230, bottomNavigationBarRow.mainAxisAlignment,
        MainAxisAlignment.spaceBetween);
    checkError(231, bottomNavigationBarRow.children, hasLength(5));

    bottomItems.asMap().forEach((index, value) {
      final bottomItem = bottomNavigationBarRow.children[index] as InkWell;
      checkError(232, bottomItem.onTap, isA<Function>());
      checkError(233, bottomItem.child, isA<SvgPicture>());

      final bottomItemSvgPicture = bottomItem.child as SvgPicture;
      checkError(234, bottomItemSvgPicture.pictureProvider.runtimeType,
          ExactAssetPicture);
      checkError(235, bottomItemSvgPicture.width, 27);
      final bottomItemSvgPicturePictureProvider =
          bottomItemSvgPicture.pictureProvider as ExactAssetPicture;
      checkError(236, bottomItemSvgPicturePictureProvider.assetName,
          bottomItems[index]);
    });
  });
}
