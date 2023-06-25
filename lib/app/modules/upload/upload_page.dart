import 'package:example_widget_testing/app/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Upload"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/upload_icon.svg",
              width: 60,
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Upload Page",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavbar(pageIndex: 2),
    );
  }
}
