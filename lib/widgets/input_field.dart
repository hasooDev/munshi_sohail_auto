import 'package:flutter/material.dart';
import 'package:sohail_auto/widgets/app_text.dart';
import '../const/res/app_color.dart';
import '../const/res/app_icons.dart';

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool labelShow;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final String? prefixIcon;
  final bool isPassword;
  final String? label;
  final Color? labelColor;
  final Color? hintColor;
  final Color? fillColor;
  final Color? prefixColor;
  final Color borderSideColor;
  final double verticalPadding;
  final TextInputAction keyboardAction;

  /// 🔎 Added search callback
  final ValueChanged<String>? onChanged;

  const InputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.verticalPadding = 12,
    this.validator,
    this.prefixIcon,
    this.isPassword = false,
    this.label,
    this.labelColor = AppColors.white,
    this.hintColor = Colors.white70,
    this.fillColor,
    this.labelShow = true,
    this.prefixColor = Colors.white,
    this.borderSideColor = AppColors.cdadee3,
    this.keyboardAction = TextInputAction.done,

    /// 🔎 added
    this.onChanged,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null && widget.label!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 2, bottom: 8),
            child: AppText(
              text: widget.label!,
              fontSize: 14,
              color: widget.labelColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        TextFormField(
          textInputAction: widget.keyboardAction,
          controller: widget.controller,
          obscureText: _obscureText,
          keyboardType: widget.keyboardType,
          style: TextStyle(
            color: widget.labelColor,
            fontFamily: "Lufga",
          ),
          validator: widget.validator,

          /// 🔎 Search function trigger
          onChanged: widget.onChanged,

          decoration: InputDecoration(
            hintText: widget.hintText,
            contentPadding: EdgeInsets.symmetric(
              vertical: widget.verticalPadding,
              horizontal: 12,
            ),
            hintStyle: TextStyle(
              fontFamily: "Lufga",
              color: widget.hintColor,
            ),
            prefixIcon: widget.prefixIcon != null
                ? Padding(
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                widget.prefixIcon!,
                height: 24,
                width: 24,
                color: widget.prefixColor,
              ),
            )
                : null,
            suffixIcon: widget.isPassword
                ? InkWell(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  _obscureText ? AppIcons.eyeOff : AppIcons.eyeOn,
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
              ),
            )
                : null,
            filled: true,
            fillColor: widget.fillColor,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: widget.borderSideColor,
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
