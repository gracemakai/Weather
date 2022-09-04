import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  String text;
  Color? textColor;
  double? fontSize;
  FontWeight? fontWeight;
  TextAlign? textAlign;
  TextOverflow? textOverflow;
  TextDecoration? textDecoration;

  CustomText(this.text,
      {this.textColor,
      this.fontSize,
      this.fontWeight,
      this.textAlign,
      this.textOverflow,
        this.textDecoration,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: textColor ?? Colors.black,
          fontSize: fontSize ?? 14.sp,
          fontWeight: fontWeight ?? FontWeight.w400,
          decoration: textDecoration ?? TextDecoration.none,
      ),
      textAlign: textAlign ?? TextAlign.start,
      overflow: textOverflow ?? TextOverflow.visible,

    );
  }
}
