
import 'package:demo_new/constant/my_colors.dart';
import 'package:flutter/material.dart';


class MyOutlinedButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final String? icon;
  final Color? borderColor;
  final bool? isUpperCase;

  const MyOutlinedButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.textStyle,
    this.borderColor,
    this.icon,
    this.isUpperCase = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: OutlinedButton(
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            BorderSide(
              color: borderColor ?? MyColors.primaryColor,
            ),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: Text(
            isUpperCase! ? title.toUpperCase() : title,
            textAlign: TextAlign.center,
            style: textStyle ??
                TextStyle(
                  color: onPressed != null
                      ? borderColor ?? MyColors.primaryColor
                      : MyColors.black200,
                ),
          ),
        ),
      ),
    );
  }
}
