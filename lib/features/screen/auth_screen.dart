import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/res/app_icons.dart';
import 'package:sohail_auto/res/app_images.dart';
import 'package:sohail_auto/res/app_strings.dart';
import 'package:sohail_auto/widgets/app_text.dart';

import '../../res/app_color.dart';
import '../../widgets/input_field.dart';
import '../../widgets/text_action.dart';
import '../controller/auth_controller.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  @override
  void initState() {
    super.initState(); // Always call this first

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutBack,
          ),
        );

    _animationController.forward(); // Only after slideAnimation is set
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: RepaintBoundary(
                child: Image.asset(AppImages.backGround, fit: BoxFit.cover),
              ),
            ),

            // Slide-in Form
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SlideTransition(
                  position: _slideAnimation,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RepaintBoundary(
                                child: Image.asset(
                                  AppIcons.appLogo,
                                  width: 74,
                                  height: 94,
                                ),
                              ),
                              AppText(
                                text: 'Welcome Back',
                                color: AppColors.white,
                                fontSize: 30,
                              ),
                              AppText(
                                text:
                                    'Please log in to your account to continue.',
                                color: AppColors.white,
                                fontSize: 13,
                              ),

                              const SizedBox(height: 16),

                              InputField(
                                controller: authController.emailController,
                                hintText: AppStrings.enterYourEmail,
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon: AppIcons.mail,
                                label: AppStrings.email,
                                fillColor: AppColors.white.withOpacity(0.3),
                              ),

                              const SizedBox(height: 16),

                              InputField(
                                controller: authController.passwordController,
                                hintText: AppStrings.enterYourPassword,
                                obscureText: true,
                                isPassword: true,
                                prefixIcon: AppIcons.password,
                                label: AppStrings.password,
                                fillColor: AppColors.white.withOpacity(0.3),
                              ),

                              const SizedBox(height: 63),

                              TextAction(
                                text: AppStrings.login,
                                backgroundColor: AppColors.ceb5757,
                                circleIcon: AppColors.softRed,
                                onPressed: () {
                                  authController.validateAndLogin();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
