import 'components/facebook_login.dart';
import 'components/forgot_access.dart';
import 'components/or_divider.dart';
import 'components/signup_section.dart';
import 'components/login_button.dart';
import 'components/password_textbox.dart';
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
    inputTextNotNull ? Navigator.pushNamed(context, '/home') : null;
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
      key: const Key('login_page_scaffold'),
      body: SafeArea(
        key: const Key('login_page_safe_area'),
        child: SingleChildScrollView(
          key: const Key('login_page_scroll_view'),
          child: ConstrainedBox(
            key: const Key('login_page_constrained_box'),
            constraints: BoxConstraints(minHeight: getAvailableHeight()),
            child: Column(
              key: const Key('login_page_column'),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  key: const Key('login_page_language_dropdown_container'),
                  width: width,
                  alignment: Alignment.topCenter,
                  child: const LanguageDropdown(),
                ),
                Column(
                  key: const Key('login_page_content_column'),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      key: const Key('login_page_instagram_logo'),
                      'assets/instagram_logo.png',
                      width: width * .5,
                    ),
                    const SizedBox(height: 15),
                    UsernameTextbox(
                      key: const Key('login_page_username_textbox'),
                      width: width,
                      checkInputNotNull: checkInputNotNull,
                      usernameController: usernameController,
                    ),
                    const SizedBox(height: 10),
                    PasswordTextbox(
                        key: const Key('login_page_password_textbox'),
                        width: width,
                        checkInputNotNull: checkInputNotNull,
                        passwordController: passwordController),
                    const SizedBox(height: 10),
                    LoginButton(
                      key: const Key('login_page_login_button'),
                      width: width,
                      inputTextNotNull: inputTextNotNull,
                      onPressed: () {
                        openHomePage();
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ForgotAccess(
                      key: const Key('login_page_forgot_access'),
                      width: width,
                    ),
                    const SizedBox(height: 15),
                    ORDivider(
                      key: const Key('login_page_or_divider'),
                      width: width,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FacebookLogin(
                      key: const Key('login_page_facebook_login'),
                      width: width,
                    ),
                  ],
                ),
                SignupSection(
                  key: const Key('login_page_signup_section'),
                  width: width,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
