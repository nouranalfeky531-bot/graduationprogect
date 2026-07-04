
import 'package:animate_do/animate_do.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_progect/modules/onboarding/prefsmanager.dart';
import '../../../core/theme/app_colors.dart';
import '../../core/resources/ap_constants.dart';
import '../../core/widgets/custom_btn.dart';
import '../coursescrean/coursescreen.dart';
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen();
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Hero(
                  //   tag: "logo",
                  //   child: Image.asset(
                  //     "assets/images/app_logo.png",
                  //     width: 50,
                  //   ),
                  // ),
                  // const SizedBox(
                  //   width: 8,
                  // ),
                  Hero(
                    tag: "appName",
                    child: Material(
                      elevation: 0,
                      color: Colors.transparent,
                      child: Text(""
                     ,
                        style: GoogleFonts.jockeyOne(
                            color: AppColors.primaryColor, fontSize: 36),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  )
                ],
              ),
              const Spacer(),
              Expanded(
                flex: 5,
                child: Center(
                    child: ZoomIn(
                        child:
                            Image.asset("assets/images/onboarding_light.png"))),
              ),
              const Spacer(),
              Text(
                "Personalize Your Experience",
                style: TextStyle(
                    fontSize: 26,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12,
              ),

              Text(
                "Your study materials, always with you.\n"
                "Choose your preferred language to get started with a comfortable, tailored experience that suits your style.",
                style:TextStyle( fontSize: 18),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Language",
                      style: TextStyle(
                          fontSize: 26,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    AnimatedToggleSwitch<String>.rolling(
                      indicatorIconScale: 1.2,
                      current:  AppConstants.defult_language,
                      values: const ["en", "ar"],
                      iconList: [
                        Image.asset("assets/images/en.png"),
                        Image.asset("assets/images/ar.png"),
                      ],
                      onChanged: (value) {
                        setState(() {
                          AppConstants.defult_language = value;
                        });
                      },
                      style: ToggleStyle(
                        backgroundColor: Colors.transparent,
                        indicatorColor: AppColors.primaryColor,
                        borderColor: AppColors.primaryColor,
                      ),

                    ),
                  ],
                ),
              ),

              const Spacer(),
              Center(
                  child: CustomBtn(
                    onTap: () async {
                      await PrefsManager.setPrefs(true);
                      if (!context.mounted) return;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => CoursesScreen()),
                      );
                    },
                text: "Let’s Start",
                isLoading: false,
                isExpanded: true,
              ))

            ],
          ),
        ),
      ),
    );
  }
}
