import 'package:flutter/material.dart';

import '../const/res/app_color.dart';

class CompanyLabel extends StatelessWidget {
  final String companyName;

  const CompanyLabel({super.key, required this.companyName});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: 
         
          TextSpan(
            text: companyName,
            style: const TextStyle(
              fontFamily: "Lufga",
              fontWeight: FontWeight.w800,
              fontSize: 17,
              color: AppColors.cffc700, // ✅ highlight with your theme color
            ),
          ),
        
      
    );
  }
}
