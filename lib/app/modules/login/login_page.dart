import 'package:example_widget_testing/app/modules/home/root_app.dart';
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
                    SizedBox(
                      width: width * .90,
                      height: width * .14,
                      child: LoginButton(
                        width: width,
                        inputTextNotNull: inputTextNotNull,
                        onPressed: () {
                          openHomePage();
                        },
                      ),
                    ),
                    SizedBox(
                      height: width * .035,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Forgot your login details? ',
                          style: TextStyle(
                            fontSize: width * .035,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            debugPrint('Get help');
                          },
                          child: Text(
                            'Get help',
                            style: TextStyle(
                              fontSize: width * .035,
                              color: const Color(0xff002588),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: width * .040,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 1,
                          width: width * .40,
                          color: const Color(0xffA2A2A2),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'OR',
                          style: TextStyle(
                            fontSize: width * .040,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 1,
                          width: width * .40,
                          color: const Color(0xffA2A2A2),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: width * .06,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/facebook.png',
                          height: width * .060,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Login with facebook',
                          style: TextStyle(
                            color: const Color(0xff1877f2),
                            fontSize: width * .040,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: width,
                        height: 1,
                        color: const Color(0xffA2A2A2),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              fontSize: width * .040,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              debugPrint('Sign Up');
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                color: const Color(0xff00258B),
                                fontSize: width * .040,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
