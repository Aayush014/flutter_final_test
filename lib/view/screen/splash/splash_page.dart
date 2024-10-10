import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_final_test/utils/color.dart';
import 'package:flutter_final_test/view/screen/home/home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 5),
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ));
      },
    );

    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Image.asset(
          'asset/splash/Note_App_Icon-removebg-preview.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
