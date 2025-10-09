import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/features/controller/home_controller.dart';
import 'package:sohail_auto/widgets/app_text.dart';
import 'package:sohail_auto/widgets/carousel_images.dart';
import 'package:sohail_auto/widgets/text_action.dart';
import '../../../const/res/app_color.dart';
import '../../../widgets/add_customer_bottom_sheet.dart';
import '../../../widgets/home_header.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  final homeController = Get.put(HomeController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// --- Fixed Top Row (Header) ---
            homeHeader(),

            /// --- Scrollable Content ---
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselImages(),




                      const SizedBox(height: 34),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: AppText(
                          text:
                          "Manage your customers, products and sales all in one place. "
                              "Use the buttons below to quickly navigate.",
                          color: AppColors.c2b2849.withAlpha(90),
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 47),

                      Padding(
                        padding:const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextAction(
                          text: "Add Customer",
                          textColor: AppColors.black,
                          onPressed: () {
                            Get.bottomSheet(
                              AddCustomerBottomSheet(),
                              backgroundColor: Colors.white,
                            );
                          },
                          backgroundColor: AppColors.cffcd6c.withAlpha(85),
                          iconShapeColor: Colors.white,
                          circleIcon: Colors.black,
                          fontSize: 17,
                          verticalPadding: 13,
                        ),
                      ),

                      // TODO: Show customer list here later
                    ],
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
