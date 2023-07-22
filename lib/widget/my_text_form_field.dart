import 'package:demo_new/constant/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatelessWidget {
  final String title, hintText;
  final Color? titleColor, backgroundColor, enabledColor, hintColor;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLength;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? textInputFormater;
  final bool? focusColorEnable, obscure, bottomPadding, fullBorder;
  final bool readOnly, showTitle;
  final double focusedBorderWidth;

  const MyTextFormField(
      {Key? key,
      this.title = '',
      this.titleColor,
      this.backgroundColor,
      this.controller,
      this.hintText = '',
      this.prefixIcon,
      this.maxLength,
      this.keyboardType,
      this.onChanged,
      this.validator,
      this.focusNode,
      this.textInputAction = TextInputAction.next,
      this.onFieldSubmitted,
      this.textCapitalization,
      this.textInputFormater,
      this.suffixIcon,
      this.focusColorEnable = false,
      this.obscure = false,
      this.readOnly = false,
      this.bottomPadding = true,
      this.showTitle = true,
      this.enabledColor,
      this.hintColor,
      this.focusedBorderWidth = 1.0,
      this.fullBorder = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 3),
        SizedBox(
          height: bottomPadding! ? 70 : 55,
          child: TextFormField(
            readOnly: readOnly,
            obscureText: obscure!,
            onFieldSubmitted: onFieldSubmitted,
            textAlignVertical: TextAlignVertical.center,
            textInputAction: textInputAction,
            onChanged: onChanged,
            keyboardType: keyboardType,
            maxLength: maxLength,
            controller: controller,
            style: const TextStyle(fontSize: 18),
            focusNode: focusNode ?? FocusNode(),
            decoration: InputDecoration(
              // enabledBorder: OutlineInputBorder(
              //   borderSide: BorderSide(
              //     color: Colors.black45,
              //   ),
              // ),
              counterText: '',
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              filled: true,
              errorStyle: const TextStyle(fontSize: 13, color: Colors.red),
              fillColor: Colors.transparent,
              hintText: hintText,
              hintStyle: TextStyle(
                color: hintColor ?? Colors.white60,
                fontSize: 18,
              ),
              prefix: Padding(
                padding: EdgeInsets.only(left: prefixIcon == null ? 15 : 0),
              ),
              contentPadding: const EdgeInsets.fromLTRB(0, 15, 15, 15),
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(4),
              // ),
              enabledBorder: fullBorder!
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                        color: MyColors.white500,
                      ),
                    )
                  : const UnderlineInputBorder(
                      borderSide: BorderSide(color: MyColors.white500),
                    ),
              focusedBorder: fullBorder!
                  ? const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: MyColors.white500,
                      ),
                    )
                  : const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: MyColors.primaryColor,
                      ),
                    ),
            ),
            validator: validator,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            inputFormatters: textInputFormater ??
                [FilteringTextInputFormatter.singleLineFormatter],
          ),
        ),
      ],
    );
  }
}
