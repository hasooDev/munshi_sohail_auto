import 'package:flutter/material.dart';
import 'package:sohail_auto/res/app_color.dart';

class TextAction extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final double verticalPadding;
  final double fontSize;
  final bool isFullWidth;
  final Color? circleIcon;
  final bool? iconShow;

  const TextAction({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.indigo,
    this.textColor = Colors.white,
    this.borderRadius = 12.0,
    this.verticalPadding = 16.0,
    this.fontSize = 16.0,
    this.isFullWidth = true,
    this.circleIcon = AppColors.c5669ff,
    this.iconShow = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: verticalPadding),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: textColor,
                      fontFamily: "Lexend",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (iconShow == true)
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: CircleAvatar(
                        backgroundColor: circleIcon,
                        radius: 15,
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
