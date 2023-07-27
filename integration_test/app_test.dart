import 'package:example_widget_testing/app/modules/account/account_page.dart';
import 'package:example_widget_testing/app/modules/activity/activity_page.dart';
import 'package:example_widget_testing/app/modules/home/home_page.dart';
import 'package:example_widget_testing/app/modules/login/login_page.dart';
import 'package:example_widget_testing/app/modules/post/post_page.dart';
import 'package:example_widget_testing/app/modules/search/search_page.dart';
import 'package:example_widget_testing/app/modules/upload/upload_page.dart';
import 'package:example_widget_testing/core/values/constant/post_json.dart';
import 'package:example_widget_testing/core/values/constant/profile_json.dart';
import 'package:example_widget_testing/core/values/constant/search_json.dart';
import 'package:example_widget_testing/core/values/constant/story_json.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  var routes = {
    '/login': (context) => const LoginPage(),
    '/home': (context) =>
        HomePage(posts: posts, stories: stories, profileData: profileJson),
    '/search': (context) => SearchPage(searchPosts: searchImages),
    '/upload': (context) => const UploadPage(),
    '/activity': (context) => const ActivityPage(),
    '/account': (context) =>
        AccountPage(profileData: profileJson, posts: posts, stories: stories),
    '/post': (context) => PostPage(posts: posts),
  };

  group('end-to-end test', () {
    testWidgets('Change dropdown value', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const LoginPage(),
        routes: routes,
      ));

      // find DropdownButton with key language_dropdown
      final Finder dropdownButton = find.byKey(const Key('language_dropdown'));

      // expect DropdownButton is found
      expect(dropdownButton, findsOneWidget);

      expect(find.text('English'), findsOneWidget);

      // tap on DropdownButton
      await tester.tap(dropdownButton);

      // move to next frame
      await tester.pumpAndSettle();

      // find DropdownMenuItem with key language_dropdown_item_Arabic
      final Finder dropdownMenuItem =
          find.byKey(const Key("language_dropdown_item_Italian"));

      expect(dropdownMenuItem, findsNWidgets(2));

      // tap on DropdownMenuItem
      await tester.tap(dropdownMenuItem.last);

      // move to next frame
      await tester.pumpAndSettle();

      // expect find text Arabic
      expect(find.text('Italian'), findsOneWidget);
    });

    testWidgets('Fill username and password then tap on login button',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const LoginPage(),
        routes: routes,
      ));

      // find TextField with key password_textfield
      final Finder passwordTextField =
          find.byKey(const Key('password_textfield'));

      // enter text into TextField
      await tester.enterText(passwordTextField, 'test');

      // find ElevatedButton with key login_button_elevated_button
      final Finder loginButton =
          find.byKey(const Key('login_button_elevated_button'));

      // tap on ElevatedButton
      await tester.tap(loginButton);

      // expect nothing happen
      await tester.pumpAndSettle();

      // find AppBar with key home_page_appbar
      final Finder appBar = find.byKey(const Key('home_page_appbar'));

      // check if AppBar is not found
      expect(appBar, findsNothing);
    });

    testWidgets('Fill username and password then tap on login button',
        (tester) async {
      // Load app widget.
      await tester.pumpWidget(MaterialApp(
        home: const LoginPage(),
        routes: routes,
      ));

      // find TextField with key username_textfield
      final Finder usernameTextField =
          find.byKey(const Key('username_textfield'));

      // enter text into TextField
      await tester.enterText(usernameTextField, 'test');

      // find TextField with key password_textfield
      final Finder passwordTextField =
          find.byKey(const Key('password_textfield'));

      // enter text into TextField
      await tester.enterText(passwordTextField, 'test');

      // find ElevatedButton with key login_button_elevated_button
      final Finder loginButton =
          find.byKey(const Key('login_button_elevated_button'));

      // tap on ElevatedButton
      await tester.tap(loginButton);

      // move to next frame
      await tester.pumpAndSettle();

      // find AppBar with key home_page_appbar
      final Finder appBar = find.byKey(const Key('home_page_appbar'));

      // check if AppBar is found
      expect(appBar, findsOneWidget);
    });

    testWidgets('Open home page then navigate to search page', (tester) async {
      // Load app widget.
      await tester.pumpWidget(MaterialApp(
        home: HomePage(
          posts: posts,
          stories: stories,
          profileData: profileJson,
        ),
        routes: routes,
      ));

      // scroll to bottom
      await tester.fling(
        find.byKey(const Key('home_page_single_child_scroll_view')),
        const Offset(0, 300),
        1000,
      );

      // find search icon in bottom navbar
      final Finder searchIcon = find.byKey(const Key('bottom_item_1'));

      // tap on search icon
      await tester.tap(searchIcon);

      // move to next frame
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // navigate to search page
      expect(find.byKey(const Key('search_page_app_bar_preferred_size')),
          findsOneWidget);

      // find search up icon in search page
      final Finder uploadIcon = find.byKey(const Key('bottom_item_2'));

      // tap on upload icon
      await tester.tap(uploadIcon);

      // move to next frame
      await tester.pumpAndSettle();

      // navigate to upload page
      expect(find.byKey(const Key('upload_page_appbar')), findsOneWidget);

      // find activity icon in bottom navbar
      final Finder activityIcon = find.byKey(const Key('bottom_item_3'));

      // tap on activity icon
      await tester.tap(activityIcon);

      // move to next frame
      await tester.pumpAndSettle();

      // navigate to activity page
      expect(find.byKey(const Key('activity_page_appbar')), findsOneWidget);

      // find account icon in bottom navbar
      final Finder accountIcon = find.byKey(const Key('bottom_item_4'));

      // tap on account icon
      await tester.tap(accountIcon);

      // move to next frame
      await tester.pumpAndSettle();

      // navigate to account page
      expect(find.byKey(const Key('app_bar_account')), findsOneWidget);
    });
  });
}
