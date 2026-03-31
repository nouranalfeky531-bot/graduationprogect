import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/modules/onboarding/onboardindprovider.dart';
import 'package:graduation_progect/modules/video/videoveiw.dart';
import 'package:media_kit/media_kit.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'modules/cotent/titlepage.dart';
import 'modules/coursescrean/coursescreen.dart';

import 'modules/lesson/lessonpage.dart';
import 'modules/onboarding/onboarding_screen.dart';
import 'modules/video/videosurvices/titleprovider.dart';
import 'modules/video/videosurvices/videoprovider.dart';




void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized(); //create
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => VideoProvider()),
          // باقي الـ providers

      ChangeNotifierProvider(create: (context) =>onboardprovider())],
      // ChangeNotifierProvider(create: (context) =>selectedtitle()

  child:  MyApp()),
  );
}



class MyApp extends StatelessWidget {

  MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<onboardprovider>(context);
    return ScreenUtilInit(
        designSize: Size(393, 852),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child)=> MaterialApp(
        // bool seen = await PrefsManager.getprefs();
      debugShowCheckedModeBanner: false,
       home:
       //Videoveiw(),
        TitlePage(),

        // TitleDropdown(),

      // CoursesScreen(),
       //  HomePage()
    //        provider.isopened?
    //  Videoveiw():
    //   OnboardingScreen(),
    )
    );
  }
}
