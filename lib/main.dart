import 'package:flutter/material.dart';
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


      home:OnboardingScreen(),
    );
  }
}
