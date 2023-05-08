import 'package:example_widget_testing/app/modules/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper.dart';

void main() {
  int point = 10;
  final states = <MaterialState>{};

  testWidgets('Check if language dropdown is present', (tester) async {
    FlutterError.onError = ignoreOverflowErrors;
    debugPrint('test 1');

    // choose the widget to be tested
    await tester.pumpWidget(
      const MaterialApp(home: LoginPage()),
    );

    // execute the test
    final dropdownButtonFinder = find.byType(DropdownButton<String>);
    final dropdownButton =
        dropdownButtonFinder.evaluate().first.widget as DropdownButton<String>;
    // check if dropdownButtonFinder has icon

    // check the widget
    expect(dropdownButtonFinder, findsOneWidget);
    try {
      expect(dropdownButton.dropdownColor, Colors.white);
    } catch (exception) {
      point -= 1;
      debugPrint('Test-1.1 failed: $exception');
    }

    expect(dropdownButton.style!.color, Colors.black54);
    expect(dropdownButton.elevation, 10);
    expect(dropdownButton.items!.length, 4);
    expect(dropdownButton.items![0].value, 'English');
    expect(dropdownButton.items![1].value, 'Arabic');
    expect(dropdownButton.items![2].value, 'Italian');
    expect(dropdownButton.items![3].value, 'French');
    // check if DropdownMenuItem<String> has Text widget
    expect(dropdownButton.items![0].child, isA<Text>());
    expect(dropdownButton.items![1].child, isA<Text>());
    expect(dropdownButton.items![2].child, isA<Text>());
    expect(dropdownButton.items![3].child, isA<Text>());
    // check if Text widget has correct text
    expect((dropdownButton.items![0].child as Text).data, 'English');
    expect((dropdownButton.items![1].child as Text).data, 'Arabic');
    expect((dropdownButton.items![2].child as Text).data, 'Italian');
    expect((dropdownButton.items![3].child as Text).data, 'French');
    // check if Text widget has correct style
    expect((dropdownButton.items![0].child as Text).style!.fontSize, 16);
    expect((dropdownButton.items![1].child as Text).style!.fontSize, 16);
    expect((dropdownButton.items![2].child as Text).style!.fontSize, 16);
    expect((dropdownButton.items![3].child as Text).style!.fontSize, 16);
  });

  testWidgets('Check if username textbox is present', (tester) async {
    FlutterError.onError = ignoreOverflowErrors;
    debugPrint('test 2');

    tester.binding.window.physicalSizeTestValue = const Size(360, 640);

    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    final usernameTextboxFinder = find.byKey(
      const Key('username_textfield'),
    );
    // expect if username textbox has correct style
    final usernameTextbox =
        usernameTextboxFinder.evaluate().first.widget as TextField;
    try {
      expect(usernameTextboxFinder, findsOneWidget);
    } catch (e) {
      point -= 1;
      debugPrint('Test-1.8 failed: $e');
    }

    try {
      expect(usernameTextbox.decoration!.hintText,
          'Phone number , email or username');
    } catch (e) {
      point -= 1;
      debugPrint('Test-1.9 failed: $e');
    }
    try {
      // check if username font size is correct for different screen size
      expect(usernameTextbox.style!.fontSize, 15);
      // console log screen size
    } catch (e) {
      point -= 1;
      debugPrint('Test-60 failed:');
      debugPrint(e.toString());
    }
    debugPrint('point: $point');
  });

  // check if password textbox is present
  testWidgets('Check if password textbox is present', (tester) async {
    FlutterError.onError = ignoreOverflowErrors;
    debugPrint('test 3');

    tester.binding.window.physicalSizeTestValue = const Size(360, 640);

    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    final passwordTextboxFinder = find.byKey(
      const Key('password_textfield'),
    );
    // expect if password textbox has correct style
    final passwordTextbox =
        passwordTextboxFinder.evaluate().first.widget as TextField;
    try {
      expect(passwordTextboxFinder, findsOneWidget);
    } catch (e) {
      point -= 1;
      debugPrint('Test-61 failed: $e');
    }

    try {
      expect(passwordTextbox.decoration!.hintText, 'Password');
    } catch (e) {
      point -= 1;
      debugPrint('Test-62 failed: $e');
    }
    // try to input password and check if it is obscured
    try {
      await tester.enterText(passwordTextboxFinder, 'password');
      expect(passwordTextbox.obscureText, true);
    } catch (e) {
      point -= 1;
      debugPrint('Test-63 failed: $e');
    }
  });

  testWidgets('Check if login button is present', (tester) async {
    FlutterError.onError = ignoreOverflowErrors;
    debugPrint('test 4');

    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    final loginButtonFinder = find.byKey(
      const Key('login_button'),
    );
    // expect if login button has correct style
    final loginButton =
        loginButtonFinder.evaluate().first.widget as ElevatedButton;
    try {
      expect(loginButtonFinder, findsOneWidget);
    } catch (e) {
      point -= 1;
      debugPrint('Test-64 failed: $e');
    }
    try {
      expect(
        loginButton.style!.backgroundColor!.resolve(states),
        const Color(0xff78c9ff),
      );
    } catch (e) {
      point -= 1;
      debugPrint('Test-65 failed:');
      debugPrint(e.toString());
    }
  });

  testWidgets('Check Forgot Login Text', (tester) async {
    FlutterError.onError = ignoreOverflowErrors;
    debugPrint('test 5');

    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    final forgotAccessFinder = find.byKey(
      const Key('forgot_access_text'),
    );

    final forgotAccessText = forgotAccessFinder.evaluate().first.widget as Text;

    try {
      expect(forgotAccessFinder, findsOneWidget);
    } catch (e) {
      point -= 1;
      debugPrint('Test-66 failed: $e');
    }

    try {
      expect(forgotAccessText.data, 'Forgot your login details? ');
    } catch (e) {
      point -= 1;
      debugPrint('Test-67 failed: $e');
    }

    try {
      expect(forgotAccessText.style!.fontSize, 13);
    } catch (e) {
      point -= 1;
      debugPrint('Test-68 failed: $e');
    }

    try {
      expect(forgotAccessText.style!.color, Colors.black);
    } catch (e) {
      point -= 1;
      debugPrint('Test-69 failed: $e');
    }

    try {
      expect(forgotAccessText.style!.fontWeight, FontWeight.normal);
    } catch (e) {
      point -= 1;
      debugPrint('Test-70 failed: $e');
    }
  });

  testWidgets('Check if Get Help text is present', (tester) async {
    FlutterError.onError = ignoreOverflowErrors;
    debugPrint('test 6');

    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    final getHelpFinder = find.byKey(
      const Key('get_help_text'),
    );

    final getHelpText = getHelpFinder.evaluate().first.widget as Text;

    try {
      expect(getHelpFinder, findsOneWidget);
    } catch (e) {
      point -= 1;
      debugPrint('Test-71 failed: $e');
    }

    try {
      expect(getHelpText.data, 'Get help');
    } catch (e) {
      point -= 1;
      debugPrint('Test-72 failed: $e');
    }

    try {
      expect(getHelpText.style!.fontSize, 13);
    } catch (e) {
      point -= 1;
      debugPrint('Test-73 failed: $e');
    }

    try {
      expect(
        getHelpText.style!.color,
        const Color(0xff002588),
      );
    } catch (e) {
      point -= 1;
      debugPrint('Test-74 failed: $e');
    }

    try {
      expect(getHelpText.style!.fontWeight, FontWeight.bold);
    } catch (e) {
      point -= 1;
      debugPrint('Test-75 failed: $e');
    }
  });

  testWidgets('Check if Facebook login is present', (tester) async {
    FlutterError.onError = ignoreOverflowErrors;
    debugPrint('test 7');

    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    final facebookLoginFinder = find.byKey(
      const Key('facebook_login'),
    );

    try {
      expect(facebookLoginFinder, findsOneWidget);
    } catch (e) {
      point -= 1;
      debugPrint('Test-76 failed: $e');
    }

    final facebookLogo = find.byKey(const Key('facebook_logo'));

    try {
      expect(facebookLogo, findsOneWidget);
    } catch (e) {
      point -= 1;
      debugPrint('Test-77 failed: $e');
    }

    final facebookTextFinder = find.byKey(
      const Key('facebook_login_text'),
    );

    final facebookText = facebookTextFinder.evaluate().first.widget as Text;

    try {
      expect(facebookTextFinder, findsOneWidget);
    } catch (e) {
      point -= 1;
      debugPrint('Test-78 failed: $e');
    }

    try {
      expect(facebookText.data, 'Login with facebook');
    } catch (e) {
      point -= 1;
      debugPrint('Test-79 failed: $e');
    }

    try {
      expect(
        facebookText.style!.color,
        const Color(0xff1877f2),
      );
    } catch (e) {
      point -= 1;
      debugPrint('Test-81 failed: $e');
    }

    try {
      expect(facebookText.style!.fontWeight, FontWeight.w800);
    } catch (e) {
      point -= 1;
      debugPrint('Test-82 failed: $e');
    }
  });

  testWidgets('Check if signup text is present', (tester) async {
    FlutterError.onError = ignoreOverflowErrors;
    debugPrint('test 8');

    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    final signupSectionFinder = find.byKey(const Key('signup_section'));
    final signupSection = signupSectionFinder.evaluate().first.widget as Row;

    try {
      expect(signupSectionFinder, findsOneWidget);
    } catch (e) {
      point -= 1;
      debugPrint('Test-82 failed:');
      debugPrint(e.toString());
    }

    try {
      expect(signupSection.children.length, 2);
    } catch (e) {
      point -= 1;
      debugPrint('Test-83 failed:');
      debugPrint(e.toString());
    }

    try {
      expect(signupSection.mainAxisAlignment, MainAxisAlignment.center);
    } catch (e) {
      point -= 1;
      debugPrint('Test-84 failed:');
      debugPrint(e.toString());
    }

    final signupText = signupSection.children[0] as Text;

    try {
      expect(signupText.runtimeType, Text);
    } catch (e) {
      point -= 1;
      debugPrint('Test-85 failed:');
      debugPrint(e.toString());
    }

    try {
      expect(signupText.data, "Don't have an account? ");
    } catch (e) {
      point -= 1;
      debugPrint('Test-86 failed:');
      debugPrint(e.toString());
    }

    try {
      expect(signupText.style!.fontSize,
          tester.binding.window.physicalSize.width * .040 / 3);
    } catch (e) {
      point -= 1;
      debugPrint('Test-87 failed:');
      debugPrint(e.toString());
    }

    final signupButton = signupSection.children[1] as TextButton;

    try {
      expect(signupButton.runtimeType, TextButton);
    } catch (e) {
      point -= 1;
      debugPrint('Test-88 failed:');
      debugPrint(e.toString());
    }

    final signupButtonText = signupButton.child as Text;

    try {
      expect(signupButtonText.runtimeType, Text);
    } catch (e) {
      point -= 1;
      debugPrint('Test-89 failed:');
      debugPrint(e.toString());
    }

    try {
      expect(signupButtonText.data, 'Sign up');
    } catch (e) {
      point -= 1;
      debugPrint('Test-90 failed:');
      debugPrint(e.toString());
    }

    try {
      expect(signupButtonText.style!.color, const Color(0xff00258B));
    } catch (e) {
      point -= 1;
      debugPrint('Test-91 failed:');
      debugPrint(e.toString());
    }

    try {
      expect(signupButtonText.style!.fontWeight, FontWeight.bold);
    } catch (e) {
      point -= 1;
      debugPrint('Test-92 failed:');
      debugPrint(e.toString());
    }

    try {
      expect(signupButtonText.style!.fontSize,
          tester.binding.window.physicalSize.width * .040 / 3);
    } catch (e) {
      point -= 1;
      debugPrint('Test-93 failed:');
      debugPrint(e.toString());
    }
  });
}
