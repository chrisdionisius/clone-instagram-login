import 'package:example_widget_testing/app/modules/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_library.dart';

const List<String> languages = <String>[
  'English',
  'Arabic',
  'Italian',
  'French'
];

void main() {
  final states = <MaterialState>{};

  testWidgets('Check if language dropdown is present', (tester) async {
    FlutterError.onError = customFlutterErrorHandler;
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));
    final dropdownButtonFinder = find.byType(DropdownButton<String>);
    final dropdownButton =
        dropdownButtonFinder.evaluate().first.widget as DropdownButton<String>;

    checkByTypeFindOneWidget(dropdownButtonFinder);
    checkWidgetProperty(
      "dropdownColor",
      dropdownButtonFinder,
      dropdownButton.dropdownColor,
      Colors.white,
    );

    checkWidgetProperty(
      "color",
      dropdownButtonFinder,
      dropdownButton.style!.color,
      Colors.black54,
    );
    checkWidgetProperty(
      "elevation",
      dropdownButtonFinder,
      dropdownButton.elevation,
      10,
    );
    for (var language in languages) {
      checkWidgetProperty(
        "Text.data",
        dropdownButtonFinder,
        (dropdownButton.items!
                .where((item) => item.value == language)
                .first
                .child as Text)
            .data,
        language,
      );
    }
    for (var language in languages) {
      checkWidgetProperty(
        "fontSize",
        dropdownButtonFinder,
        (dropdownButton.items!
                .where((item) => item.value == language)
                .first
                .child as Text)
            .style!
            .fontSize,
        16,
      );
    }
  });

  testWidgets('Check if username textbox is present', (tester) async {
    FlutterError.onError = customFlutterErrorHandler;
    tester.binding.window.physicalSizeTestValue = const Size(360, 640);
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

    await tester.pumpWidget(const MaterialApp(home: LoginPage()));
    final usernameTextboxFinder = find.byKey(const Key('username_textfield'));

    final usernameTextbox =
        usernameTextboxFinder.evaluate().first.widget as TextField;
    checkByKeyFindOneWidget(usernameTextboxFinder);
    checkWidgetProperty(
      "hintText",
      usernameTextboxFinder,
      usernameTextbox.decoration!.hintText,
      'Phone number , email or username',
    );
    checkWidgetProperty(
      "fontSize",
      usernameTextboxFinder,
      usernameTextbox.style!.fontSize,
      15,
    );
  });

  testWidgets('Check if password textbox is present', (tester) async {
    FlutterError.onError = customFlutterErrorHandler;
    tester.binding.window.physicalSizeTestValue = const Size(360, 640);
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    final passwordTextboxFinder = find.byKey(const Key('password_textfield'));
    checkByKeyFindOneWidget(passwordTextboxFinder);

    final passwordTextbox =
        passwordTextboxFinder.evaluate().first.widget as TextField;
    checkWidgetProperty(
      "hintText",
      passwordTextboxFinder,
      passwordTextbox.decoration!.hintText,
      'Password',
    );

    await tester.enterText(passwordTextboxFinder, 'password');
    checkWidgetProperty(
      "obscureText",
      passwordTextboxFinder,
      passwordTextbox.obscureText,
      true,
    );
  });

  testWidgets('Check if login button is present', (tester) async {
    FlutterError.onError = customFlutterErrorHandler;
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    final loginButtonFinder = find.byKey(
      const Key('login_button_elevated_button'),
    );

    final loginButton =
        loginButtonFinder.evaluate().first.widget as ElevatedButton;
    checkByKeyFindOneWidget(loginButtonFinder);
    checkWidgetProperty(
      "backgroundColor",
      loginButtonFinder,
      loginButton.style!.backgroundColor!.resolve(states),
      const Color(0xff78c9ff),
    );
  });

  testWidgets('Check Forgot Login Text', (tester) async {
    FlutterError.onError = customFlutterErrorHandler;
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    final forgotAccessFinder = find.byKey(const Key('forgot_access_text'));
    checkByKeyFindOneWidget(forgotAccessFinder);

    final forgotAccessText = forgotAccessFinder.evaluate().first.widget as Text;
    checkWidgetProperty(
      "Text.data",
      forgotAccessFinder,
      forgotAccessText.data,
      'Forgot your login details? ',
    );
    checkWidgetProperty(
      "fontSize",
      forgotAccessFinder,
      forgotAccessText.style!.fontSize,
      13,
    );
    checkWidgetProperty(
      "color",
      forgotAccessFinder,
      forgotAccessText.style!.color,
      Colors.black,
    );
    checkWidgetProperty(
      "fontWeight",
      forgotAccessFinder,
      forgotAccessText.style!.fontWeight,
      FontWeight.normal,
    );
  });

  testWidgets('Check if Get Help text is present', (tester) async {
    FlutterError.onError = customFlutterErrorHandler;

    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    final getHelpFinder = find.byKey(const Key('get_help_text'));
    checkByKeyFindOneWidget(getHelpFinder);

    final getHelpText = getHelpFinder.evaluate().first.widget as Text;
    checkWidgetProperty(
      "Text.data",
      getHelpFinder,
      getHelpText.data,
      'Get help',
    );
    checkWidgetProperty(
      "fontSize",
      getHelpFinder,
      getHelpText.style!.fontSize,
      13,
    );
    checkWidgetProperty(
      "color",
      getHelpFinder,
      getHelpText.style!.color,
      const Color(0xff002588),
    );
    checkWidgetProperty(
      "fontWeight",
      getHelpFinder,
      getHelpText.style!.fontWeight,
      FontWeight.bold,
    );
  });

  testWidgets('Check if Facebook login is present', (tester) async {
    FlutterError.onError = customFlutterErrorHandler;

    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    final facebookLoginFinder = find.byKey(const Key('facebook_login'));
    checkByKeyFindOneWidget(facebookLoginFinder);

    final facebookLogo = find.byKey(const Key('facebook_logo'));
    checkByKeyFindOneWidget(facebookLogo);

    final facebookTextFinder = find.byKey(const Key('facebook_login_text'));
    checkByKeyFindOneWidget(facebookTextFinder);

    final facebookText = facebookTextFinder.evaluate().first.widget as Text;
    checkWidgetProperty(
      "Text.data",
      facebookTextFinder,
      facebookText.data,
      'Login with facebook',
    );
    checkWidgetProperty(
      "color",
      facebookTextFinder,
      facebookText.style!.color,
      const Color(0xff1877f2),
    );
    checkWidgetProperty(
      "fontWeight",
      facebookTextFinder,
      facebookText.style!.fontWeight,
      FontWeight.w800,
    );
  });

  testWidgets('Check if signup text is present', (tester) async {
    FlutterError.onError = customFlutterErrorHandler;

    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    final signupSectionFinder = find.byKey(const Key('signup_section'));
    checkByKeyFindOneWidget(signupSectionFinder);

    final signupSection = signupSectionFinder.evaluate().first.widget as Row;
    checkWidgetProperty(
      "mainAxisAlignment",
      signupSectionFinder,
      signupSection.mainAxisAlignment,
      MainAxisAlignment.center,
    );

    final signupText = signupSection.children[0] as Text;
    checkWidgetProperty(
      "Text.data",
      signupSectionFinder.first,
      signupText.data,
      "Don't have an account? ",
    );

    checkWidgetProperty(
      "fontSize",
      signupSectionFinder,
      signupText.style!.fontSize,
      tester.binding.window.physicalSize.width * .040 / 3,
    );

    final signupButton = signupSection.children[1] as TextButton;
    final signupButtonText = signupButton.child as Text;
    checkWidgetProperty(
      "Text.data",
      signupSectionFinder,
      signupButtonText.data,
      'Sign up',
    );
    checkWidgetProperty(
      "color",
      signupSectionFinder,
      signupButtonText.style!.color,
      const Color(0xff00258B),
    );
    checkWidgetProperty(
      "fontWeight",
      signupSectionFinder,
      signupButtonText.style!.fontWeight,
      FontWeight.bold,
    );
    checkWidgetProperty(
      "fontSize",
      signupSectionFinder,
      signupButtonText.style!.fontSize,
      tester.binding.window.physicalSize.width * .040 / 3,
    );
  });
}
