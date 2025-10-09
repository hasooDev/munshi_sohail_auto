import 'package:device_frame_plus/device_frame_plus.dart';
import 'package:flutter/material.dart';

import 'munshi_sohail_auto.dart';

class MyAppWithFrame extends StatelessWidget {
  const MyAppWithFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DeviceFrame(
        device: Devices.ios.iPhone12,
        isFrameVisible: true,
        orientation: Orientation.portrait,
        screen: const MunshiSohailAuto(), // ✅ Your GetMaterialApp lives here
      ),
    );
  }
}