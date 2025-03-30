import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    required this.text,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.overflow,
    this.maxLines,
    this.textDecoration,
    this.textAlign,
    super.key,
  });
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextDecoration? textDecoration;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        decoration: textDecoration,
        overflow: overflow,
      ),
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
