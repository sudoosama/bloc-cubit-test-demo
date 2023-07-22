import 'package:flutter/material.dart';

import '../constant/my_colors.dart';

class MyAnimatedLoaderButton extends StatelessWidget {
  final bool? loader, isUpperCase;
  final VoidCallback? onPressed;
  final String? text;
  final Color? buttonBGColor,
      buttonBackgroundColor,
      disabledTextColor,
      textColor,
      loaderColor;
  final double height, loaderWidth;
  final EdgeInsets? margin;

  const MyAnimatedLoaderButton({
    Key? key,
    this.loader,
    this.onPressed,
    this.text,
    this.buttonBGColor,
    this.margin,
    this.height = 45,
    this.loaderWidth = 45,
    this.buttonBackgroundColor,
    this.disabledTextColor = MyColors.black200,
    this.loaderColor = MyColors.white,
    this.isUpperCase = true,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.center,
          child: AnimatedContainer(
            margin: margin ?? const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: onPressed != null
                  ? buttonBGColor ?? MyColors.primaryColor
                  : MyColors.transparent,
              borderRadius: BorderRadius.circular(loader! ? 30 : 5),
            ),
            duration: const Duration(milliseconds: 500),
            height: height,
            width: loader! ? loaderWidth : MediaQuery.of(context).size.width,
            child: loader!
                ? Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    loaderColor ?? MyColors.white,
                  ),
                ),
              ),
            )
                : ElevatedButton(
              onPressed: onPressed,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: FittedBox(
                  child: Text(
                    loader!
                        ? ""
                        : isUpperCase!
                        ? text!.toUpperCase()
                        : text!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: onPressed != null
                          ? textColor ?? MyColors.black
                          : disabledTextColor,
                    ),
                  ),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  onPressed != null ? buttonBackgroundColor : null,
                ),
                shape: ButtonStyleButton.allOrNull<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(loader! ? 30.0 : 5),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
