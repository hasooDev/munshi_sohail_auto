import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/const/res/app_icons.dart';
import 'package:sohail_auto/widgets/app_text.dart';
import 'package:sohail_auto/widgets/background_image.dart';

import '../../../const/res/app_strings.dart';
import '../../../services/splash_control_services.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashControllService controller = Get.put(SplashControllService());

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              /// 🔹 Logo + Title
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 68.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    mainAxisAlignment: MainAxisAlignment.center,
                  
                    children: [
                      Image(
                                image: AssetImage(AppIcons.logo),
                                fit: BoxFit.cover,
                                height: 123,
                                color: Colors.white,
                              ).animate()
                  .fadeIn(duration: 4500.ms),
                      AppText(
                        text: AppStrings.appName,
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                      ).animate().fadeIn(duration: 4500.ms),
                      SizedBox(height: 7),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: AppText(
                              text: AppStrings.appTitle,
                              color: Colors.black,
                              fontSize: 15,
                              textAlign: TextAlign.center,
                            )
                            .animate()
                            .fadeIn(duration: 4500.ms)
                            .shimmer(
                              duration: Duration(seconds: 2),
                              colors: [Colors.white, Colors.lightBlueAccent],
                            )
                            .slideY(begin: 1, end: 0, curve: Curves.easeOut),
                      ),
                    ],
                  ),
                ),
              ),

              /// 🔹 Bottom Loader + Loading Text
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 127),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                            height: 67,
                            width: 67,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: SpinKitFadingCircle(
                                color: Colors.redAccent,
                                size: 40,
                              ),
                            ),
                          )
                    ],
                  ),
                ),
              ) .animate()
                  .fadeIn(duration: 4500.ms)
            ],
          ),
        ),
      ),
    );
  }
}
