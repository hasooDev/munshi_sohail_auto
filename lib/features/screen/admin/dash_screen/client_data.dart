import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sohail_auto/features/controller/consumer_data_controller.dart';
import 'package:sohail_auto/models/admin/consumer_data_model.dart';
import 'package:sohail_auto/widgets/add_consumer_data_widget.dart';
import 'package:sohail_auto/widgets/app_text.dart';
import 'package:sohail_auto/widgets/consumer_card.dart';
import 'package:sohail_auto/widgets/custom_app_bar.dart';

import '../../../../const/res/app_color.dart';

class ClientData extends StatefulWidget {
  const ClientData({super.key});

  @override
  State<ClientData> createState() => _ClientDataState();
}

class _ClientDataState extends State<ClientData> {
  final consumerController = Get.put(ConsumerController());

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      consumerController.isLoading.value = true;
      await consumerController.fetchConsumers();
      consumerController.isLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppBar(title: "Consumer Information"),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.c5669ff,
            onPressed: () {
              Get.bottomSheet(
                buildConsumer(context),
                backgroundColor: AppColors.white,
              );
            },
            child: const Icon(Icons.add, color: AppColors.white),
          ),
          body: Obx(() {
            if (consumerController.consumerList.isEmpty &&
                !consumerController.isLoading.value) {
              return const Center(child: AppText(text: "No Consumer Data Found"));
            }
            return ListView.builder(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              itemCount: consumerController.consumerList.length,
              itemBuilder: (context, index) {
                final ConsumerModel consumer = consumerController.consumerList[index];
                return consumerCard(context, consumer);
              },
            );
          }),
        ),

        // Loader Overlay
        Obx(() {
          if (!consumerController.isLoading.value) return const SizedBox.shrink();
          return Container(
            color: Colors.black45, // semi-transparent background
            child: Center(
              child: Container(
                height: 94,
                width: 94,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(19),
                ),
                child: SpinKitFadingCircle(
                  color: Colors.indigo.withOpacity(0.5),
                  size: 56,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
