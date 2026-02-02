import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? height;
  final double? width;
  final double elevation;
  final Color? color;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Color? fontColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final BorderSide? borderside;
  final bool? isDisabled;
  final bool isLoading;
  TextStyle? style;

  CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height,
    this.width,
    this.elevation = 0.0,
    this.color,
    this.borderRadius = 100,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.fontColor = white,
    this.fontSize = 16.0,
    this.fontWeight, 
    this.borderside,
    this.style, 
    this.isDisabled = false, 
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: SizedBox(
        height: height ?? 54.h,
        width: width,
        child: ElevatedButton(
          onPressed: isLoading == true || isDisabled == true ? (){} : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: isDisabled == true ? grey2 : color ?? darkBlue,
            padding: padding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            elevation: elevation,
            // textStyle: TextStyle(
            //   color: fontColor,
            //   fontSize: read('appFont') == "large" ? 20 : fontSize,
            //   fontWeight: fontWeight,
            // ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            animationDuration: const Duration(milliseconds: 200),
            shadowColor: grey2,
            side: borderside ?? BorderSide.none,
          ),
          child: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(fontColor ?? darkBlue),
              ),
            )
          : FittedBox(
            child: Text(
              text,
              style: style ?? interSemiBold(size: 14.sp, color: fontColor)
            ),
          ),
        ),
      ),
    );
  }

}
