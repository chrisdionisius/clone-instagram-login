import 'package:example_widget_testing/app/modules/home/home_page.dart';
import 'package:example_widget_testing/app/modules/login/components/facebook_login.dart';
import 'package:example_widget_testing/app/modules/login/components/forgot_access.dart';
import 'package:example_widget_testing/app/modules/login/components/or_divider.dart';
import 'package:example_widget_testing/app/modules/login/components/signup_section.dart';
import 'package:example_widget_testing/app/modules/login/components/login_button.dart';
import 'package:example_widget_testing/app/modules/login/components/password_textbox.dart';
import 'package:flutter/material.dart';

import 'components/language_dropdown.dart';
import 'components/username_textbox.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  int buttonColor = 0xff26A9FF;

  bool inputTextNotNull = false;

  void checkInputNotNull() {
    setState(() {
      if (usernameController.text.length >= 2 &&
          passwordController.text.length >= 2) {
        inputTextNotNull = true;
      } else {
        inputTextNotNull = false;
      }
    });
  }

  void openHomePage() {
    inputTextNotNull
        ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    double getAvailableHeight() {
      return height -
          MediaQuery.of(context).padding.top -
          MediaQuery.of(context).padding.bottom;
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: getAvailableHeight()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width,
                  alignment: Alignment.topCenter,
                  child: const LanguageDropdown(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/instagram_logo.png',
                      width: width * .5,
                    ),
                    const SizedBox(height: 15),
                    UsernameTextbox(
                      width: width,
                      checkInputNotNull: checkInputNotNull,
                      usernameController: usernameController,
                    ),
                    const SizedBox(height: 10),
                    PasswordTextbox(
                        width: width,
                        checkInputNotNull: checkInputNotNull,
                        passwordController: passwordController),
                    const SizedBox(height: 10),
                    LoginButton(
                      width: width,
                      inputTextNotNull: inputTextNotNull,
                      onPressed: () {
                        openHomePage();
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ForgotAccess(width: width),
                    const SizedBox(height: 15),
                    ORDivider(
                      width: width,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FacebookLogin(width: width),
                  ],
                ),
                SignupSection(width: width),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
