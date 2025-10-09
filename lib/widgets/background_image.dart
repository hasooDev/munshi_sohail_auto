import 'package:flutter/material.dart';

import '../const/res/app_images.dart';

class BackgroundImage extends StatelessWidget {
  final Widget child;
  const BackgroundImage({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
         image:  DecorationImage(image: AssetImage(AppImages.backGround),fit: BoxFit.cover)
      ),
      child: child,
    );
  }
}
