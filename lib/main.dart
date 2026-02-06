import 'package:flutter/material.dart';
import 'package:graduation_progect/modules/video/videoveiw.dart';
import 'modules/onboarding/onboarding_screen.dart';




void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,


      home:Videoveiw(),
      //OnboardingScreen(),
    );
  }
}
