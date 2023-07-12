import 'package:flutter/material.dart';

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

    throw UnimplementedError();
  }
}
