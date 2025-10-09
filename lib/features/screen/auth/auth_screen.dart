import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sohail_auto/widgets/app_text.dart';
import 'package:sohail_auto/widgets/gradient.dart';

import '../../../const/res/app_color.dart';
import '../../../const/res/app_icons.dart';
import '../../../const/res/app_strings.dart';
import '../../../widgets/input_field.dart';
import '../../../widgets/memory_dailog.dart';
import '../../../widgets/text_action.dart';
import '../../controller/auth_controller.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    // Show memorial dialog when AuthScreen opens
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      bool hasSeenDialog = prefs.getBool("hasSeenMemorialDialog") ?? false;

      if (!hasSeenDialog) {
        showMemorialDialog(prefs, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.15),
                              Colors.white.withOpacity(0.05),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image(
                                image: AssetImage(AppIcons.logo),
                                fit: BoxFit.cover,
                                height: 123,
                                  color: Colors.black.withOpacity(0.7),
                              ).animate()
                              .scaleX(
                                begin: -1,
                                    duration: 600.ms,
                                    curve: Curves.easeOut,
                              )
                  .fadeIn(duration: 4500.ms),
                              AppText(
                                    text: AppStrings.welcome,
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 23,
                                    fontWeight: FontWeight.w800,
                                  )
                                  .animate()
                                  .slideX(
                                    begin: -1,
                                    duration: 600.ms,
                                    curve: Curves.easeOut,
                                  )
                                  .fadeIn(duration: 600.ms),
                              const SizedBox(height: 13),
                              AppText(
                                    text: AppStrings.welcomeTitle,
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  )
                                  .animate()
                                  .slideX(
                                    begin: -1,
                                    duration: 600.ms,
                                    curve: Curves.easeOut,
                                  )
                                  .fadeIn(duration: 600.ms),

                              const SizedBox(height: 26),

                              // Email Input
                              InputField(
                                    controller: authController.emailController,
                                    hintText: AppStrings.enterYourEmail,
                                    keyboardType: TextInputType.emailAddress,
                                    prefixIcon: AppIcons.email,
                                    label: AppStrings.email,
                                    fillColor: AppColors.white.withOpacity(0.3),
                                    keyboardAction: TextInputAction.next,
                                  )
                                  .animate()
                                  .slideX(
                                    begin: -1,
                                    duration: 600.ms,
                                    curve: Curves.easeOut,
                                  )
                                  .fadeIn(duration: 600.ms),

                              const SizedBox(height: 16),

                              // Password Input
                              InputField(
                                    controller:
                                        authController.passwordController,
                                    hintText: AppStrings.enterYourPassword,
                                    obscureText: true,
                                    isPassword: true,
                                    prefixIcon: AppIcons.password,
                                    label: AppStrings.password,
                                    fillColor: AppColors.white.withOpacity(0.3),
                                  )
                                  .animate()
                                  .slideX(
                                    begin: -1,
                                    duration: 600.ms,
                                    curve: Curves.easeOut,
                                  )
                                  .fadeIn(duration: 600.ms),

                              const SizedBox(height: 33),

                              // Login Button
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0,
                                ),
                                child:
                                    TextAction(
                                          text: AppStrings.login,
                                          textColor: AppColors.white,
                                          backgroundColor: AppColors.white
                                              .withOpacity(0.1),
                                          fontSize: 18,
                                          circleIcon: AppColors.white,
                                          iconShapeColor: Colors.black,
                                          verticalPadding: 12,
                                          onPressed: () {
                                            authController.validateAndLogin();
                                          },
                                        )
                                        .animate()
                                        .slideX(
                                          begin: -1,
                                          duration: 600.ms,
                                          curve: Curves.easeOut,
                                        )
                                        .fadeIn(duration: 600.ms),
                              ),

                              const SizedBox(height: 33),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Loader Overlay
              Obx(() {
                return authController.isLoading.value
                    ? Container(
                        color: Colors.black.withOpacity(0.5),
                        child: Center(
                          child: Container(
                            height: 64,
                            width: 64,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(19),
                            ),
                            child: authController.loader,
                          ),
                        ),
                      )
                    : const SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
