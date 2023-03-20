import 'package:example_widget_testing/app/modules/login/components/facebook_login.dart';
import 'package:example_widget_testing/app/modules/login/components/forgot_access.dart';
import 'package:example_widget_testing/app/modules/login/components/or_divider.dart';
import 'package:example_widget_testing/app/modules/login/components/signup_section.dart';
import 'package:example_widget_testing/app/root_app.dart';
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
              builder: (context) => const RootApp(),
            ),
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 90,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topCenter,
                  child: const LanguageDropdown(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/instagram_logo.png',
                      height: width * .20,
                    ),
                    SizedBox(
                      height: width * .05,
                    ),
                    UsernameTextbox(
                      width: width,
                      checkInputNotNull: checkInputNotNull,
                      usernameController: usernameController,
                    ),
                    SizedBox(
                      height: width * .04,
                    ),
                    PasswordTextbox(
                        width: width,
                        checkInputNotNull: checkInputNotNull,
                        passwordController: passwordController),
                    SizedBox(
                      height: width * .04,
                    ),
                    LoginButton(
                      width: width,
                      inputTextNotNull: inputTextNotNull,
                      onPressed: () {
                        openHomePage();
                      },
                    ),
                    SizedBox(
                      height: width * .035,
                    ),
                    ForgotAccess(width: width),
                    SizedBox(
                      height: width * .040,
                    ),
                    ORDivider(
                      width: width,
                    ),
                    SizedBox(
                      height: width * .06,
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
